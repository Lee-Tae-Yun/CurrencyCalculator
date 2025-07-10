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
    guard let text = calculator.amountTextField.text, !text.isEmpty else {
      showAlert(message: "금액을 입력해주세요")
      return
    }
    guard let amount = Double(text) else {
      showAlert(message: "올바른 숫자를 입력해주세요")
      return
    }
    guard let code = countryCode, let transrate = rate else { return }
    let result = amount * transrate
    calculator.resultLabel.text = "$" + format2f(amount) + " → " + format2f(result) + " " + code
  }

  func format2f(_ text: Double) -> String {
    return String(format: "%.2f", text)
  }

  private func showAlert(message: String) {
    let alert = UIAlertController(title: "입력 오류", message: message, preferredStyle: .alert)
    alert.addAction(UIAlertAction(title: "확인", style: .default))
    present(alert, animated: true)
  }
}

