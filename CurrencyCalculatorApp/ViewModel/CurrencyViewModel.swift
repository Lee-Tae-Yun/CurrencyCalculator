//
//  CurrencyViewModel.swift
//  CurrencyCalculatorApp
//
//  Created by 이태윤 on 7/7/25.
//

import UIKit
import CoreData

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
        self.loadFavoritesFromCoreData()
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
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    // 즐겨찾기 제거
    if let favIndex = state.favoriteItems.firstIndex(where: { $0.code == code }) {
      if let itemIndex = state.items.firstIndex(where: { $0.code == code }) {
        state.items[itemIndex].isFavorite = false
      }
      state.favoriteItems.remove(at: favIndex)

      // Core Data에서 삭제
      let fetchRequest: NSFetchRequest<FavoriteCurrency> = FavoriteCurrency.fetchRequest()
      fetchRequest.predicate = NSPredicate(format: "code == %@", code)
      if let result = try? context.fetch(fetchRequest), let objectToDelete = result.first {
        context.delete(objectToDelete)
        try? context.save()
      }

    } else if let itemIndex = state.items.firstIndex(where: { $0.code == code }) {
      // 즐겨찾기 추가
      var item = state.items[itemIndex]
      item.isFavorite = true
      state.favoriteItems.append(item)

      // Core Data에 저장
      let newFavorite = FavoriteCurrency(context: context)
      newFavorite.code = item.code
      try? context.save()
    }

    // 즐겨찾기 정렬
    state.favoriteItems.sort { $0.code < $1.code }

    // 즐겨찾기를 제외한 필터 리스트 재구성
    state.filteredItems = state.items.filter { item in
      !state.favoriteItems.contains(where: { $0.code == item.code })
    }

    onStateChanged?(state)
  }

  func loadFavoritesFromCoreData() {
    // Core Data의 Context 가져오기
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    // FavoriteCurrency 엔티티를 불러오기 위한 요청 생성
    let fetchRequest: NSFetchRequest<FavoriteCurrency> = FavoriteCurrency.fetchRequest()
    // 저장된 즐겨찾기 코드만 추출
    if let savedCodes = try? context.fetch(fetchRequest).compactMap({ $0.code }) {
      // items 중 저장된 코드와 일치하는 항목만 즐겨찾기 리스트에 담기
      state.favoriteItems = state.items.filter { savedCodes.contains($0.code) }
      // isFavorite 값을 true로 바꿔주기
      state.items = state.items.map { item in
        var updatedItem = item
        updatedItem.isFavorite = savedCodes.contains(item.code)
        return updatedItem
      }
      // 필터된 항목도 갱신
      state.filteredItems = state.items.filter { item in
        !savedCodes.contains(item.code)
      }
      // 정렬
      state.favoriteItems.sort { $0.code < $1.code }
      onStateChanged?(state)
    }
  }
}
