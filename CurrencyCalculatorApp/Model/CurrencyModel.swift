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
}

enum CurrencyBase: String {
  case usd = "USD"
  case krw = "KRW"
}
