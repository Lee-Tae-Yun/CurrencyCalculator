//
//  CalculatorViewController.swift
//  CurrencyCalculatorApp
//
//  Created by 이태윤 on 7/10/25.
//
import UIKit

class CalculatorViewController: UIViewController {
  let calculator = CalculatorView()
  let calculatorVM: CalculatorViewModel

  init(viewModel: CalculatorViewModel) {
    self.calculatorVM = viewModel
    super.init(nibName: nil, bundle: nil)
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  override func loadView() {
    view = calculator
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    bindViewModel()
    calculator.convertButton.addTarget(self, action: #selector(convertButtonDidTap), for: .touchUpInside)
  }
  private func bindViewModel() {
    calculator.calcuatorConfigure(
      code: calculatorVM.state.countryCode,
      country: calculatorVM.state.countryName
    )
  }
  @objc private func convertButtonDidTap() {
    calculatorVM.action(.calculate(text: calculator.amountTextField.text ?? ""))
    if !self.calculatorVM.state.message.isEmpty {
      showAlert(message: self.calculatorVM.state.message)
    } else {
      calculator.resultLabel.text = calculatorVM.state.result
    }
  }

  private func showAlert(message: String) {
    let alert = UIAlertController(title: "입력 오류", message: message, preferredStyle: .alert)
    alert.addAction(UIAlertAction(title: "확인", style: .default))
    present(alert, animated: true)
  }
}

