//
//  CurrencyService.swift
//  CurrencyCalculatorApp
//
//  Created by 이태윤 on 7/7/25.
//
import Foundation
import Alamofire

final class CurrencyService {
  let URL = "https://open.er-api.com/v6/latest/"

  func fetchCurrency(base: CurrencyBase, completion: @escaping (Result<CurrencyModel, AFError>) -> Void) {
    let url = URL + base.rawValue

    AF.request(url)
      .validate()
      .responseDecodable(of: CurrencyModel.self) { response in
        completion(response.result)
      }
  }
}
