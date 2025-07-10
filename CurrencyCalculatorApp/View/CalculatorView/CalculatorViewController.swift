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
    calculator.convertButton.addTarget(self, action: #selector(convertButtonDidTap), for: .touchUpInside)
  }

  @objc private func convertButtonDidTap() {
    guard let text = calculator.amountTextField.text,
          let amoount = Double(text),
          let code = countryCode,
          let rate = rate else {
      calculator.resultLabel.text = "올바른 숫자를 입력해 주세요"
      return
    }

    let result = amoount * rate
    calculator.resultLabel.text = "$" + format2f(amoount) + " → " + format2f(result) + " " + code
  }

  func format2f(_ text: Double) -> String {
    return String(format: "%.2f", text)
  }
}

