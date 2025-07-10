//
//  CalculatorViewController.swift
//  CurrencyCalculatorApp
//
//  Created by 이태윤 on 7/10/25.
//
import UIKit

class CalculatorViewController: UIViewController {
  let calculator = CalculatorView()
  var countryCode: String?
  var countryName: String?
  var rate: Double?

  override func loadView() {
    view = calculator
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    calculator.calcuatorConfigure(code: countryCode ?? "국가코드 없음", country: countryName ?? "국가명 없음")
  }
}
