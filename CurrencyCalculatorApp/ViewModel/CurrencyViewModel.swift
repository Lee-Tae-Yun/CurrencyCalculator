//
//  CurrencyViewModel.swift
//  CurrencyCalculatorApp
//
//  Created by 이태윤 on 7/7/25.
//

final class CurrencyViewModel: ViewModelProtocol {
  enum Action {
    case loadData
    case filter(searchText: String)
    case toggleFavorite(String)
  }

  struct State {
    var items: [CurrencyItem] = []
    var filteredItems: [CurrencyItem] = []
    var favoriteItems: [CurrencyItem] = []
    var countryName: String? = nil
    var base = CurrencyBase.usd
    var errorMessage: String? = nil
    var isEmptyHidden: Bool = true
  }

  var onStateChanged: ((State) -> Void)?
  private(set) var state = State()
  private let currencyService = CurrencyService()

  func action(_ action: Action) {
    switch action {
    case .loadData:
      loadData()
    case .filter(let searchText):
      filter(searchText: searchText)
    case .toggleFavorite(let code):
      toggleFavorite(code: code)
    }
  }

  private func loadData() {
    currencyService.fetchCurrency(base: state.base) { result in
      switch result {
      case .success(let currency):
        self.state.items = currency.items
        self.state.filteredItems = currency.items // 초기에 전체를 보여주기
        self.onStateChanged?(self.state)
      case .failure(let error):
        print("error: \(error)")
        self.state.errorMessage = "데이터를 불러오지 못했습니다."
        self.onStateChanged?(self.state)
      }
    }
  }

  private func filter(searchText: String) {
    if searchText.isEmpty {
      // 전체 보기일 때는 즐겨찾기 제외
      state.filteredItems = state.items.filter { item in
        !state.favoriteItems.contains(where: { $0.code == item.code })
      }
    } else {
      state.filteredItems = state.items.filter { item in
        let codeMatch = item.code.lowercased().contains(searchText.lowercased())
        let countryMatch = item.currencyName.contains(searchText)
        return codeMatch || countryMatch
      }
    }
    state.isEmptyHidden = !(state.filteredItems.isEmpty && !searchText.isEmpty)
    onStateChanged?(self.state)
  }

  private func toggleFavorite(code: String) {
    // 즐겨찾기 제거
    if let favIndex = state.favoriteItems.firstIndex(where: { $0.code == code }) {
      var removedItem = state.favoriteItems[favIndex]
      removedItem.isFavorite = false
      state.favoriteItems.remove(at: favIndex)

      if let itemIndex = state.items.firstIndex(where: { $0.code == code }) {
        state.items[itemIndex] = removedItem
      }
    }
    // 즐겨찾기 추가
    else if let itemIndex = state.items.firstIndex(where: { $0.code == code }) {
      var item = state.items[itemIndex]
      item.isFavorite = true
      state.items[itemIndex] = item
      state.favoriteItems.append(item)
    }

    // 즐겨찾기 정렬
    state.favoriteItems.sort { $0.code < $1.code }

    // 필터링된 목록 업데이트
    state.filteredItems = state.items.filter { item in
      !state.favoriteItems.contains(where: { $0.code == item.code })
    }

    onStateChanged?(state)
  }
}
