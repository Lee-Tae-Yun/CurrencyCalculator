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
  }
  
  struct State {
    var items: [CurrencyItem] = []
    var filteredItems: [CurrencyItem] = []
    var favoriteItems: [CurrencyItem] = []
    var countryName: String? = nil
    var base = CurrencyBase.usd
    var errorMessage: String? = nil
    var isEmptyHidden: Bool = true
    var isFavorite: Bool = false
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
      self.state.filteredItems = self.state.items
    } else {
      self.state.filteredItems = self.state.items.filter { item in
        let codeMatch = item.code.lowercased().contains(searchText.lowercased())
        let countryMatch = item.currencyName.contains(searchText)
        return codeMatch || countryMatch
      }
    }
    self.state.isEmptyHidden = !(self.state.filteredItems.isEmpty && !searchText.isEmpty)
    self.onStateChanged?(self.state)
  }
}

