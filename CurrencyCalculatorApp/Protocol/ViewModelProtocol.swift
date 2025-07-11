//
//  ViewModelProtocol.swift
//  CurrencyCalculatorApp
//
//  Created by 이태윤 on 7/10/25.
//

protocol ViewModelProtocol {
  associatedtype Action
  associatedtype State
  
  func action(_ action: Action)
  var state: State { get }
}
