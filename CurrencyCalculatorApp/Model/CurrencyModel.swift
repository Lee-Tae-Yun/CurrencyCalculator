//
//  CurrencyModel.swift
//  CurrencyCalculatorApp
//
//  Created by 이태윤 on 7/7/25.
//
import Foundation

struct CurrencyModel: Codable {
  let result: String
  let baseCode: String
  let rates: [String: Double]

  enum CodingKeys: String, CodingKey {
    case result
    case baseCode = "base_code"
    case rates
  }
}

struct CurrencyItem {
  let code: String
  let rate: Double
  let currencyName: String
  var isFavorite: Bool
}

enum CurrencyBase: String {
  case usd = "USD"
  case krw = "KRW"
}

extension CurrencyModel {
  var items: [CurrencyItem] {
    rates
      .map { CurrencyItem(code: $0.key, rate: $0.value, currencyName: CountryModel.countryList[$0.key] ?? $0.key, isFavorite: false) }
      .sorted { $0.code.lowercased() < $1.code.lowercased() }
  }
}
