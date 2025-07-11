//
//  CalculatorViewModel.swift
//  CurrencyCalculatorApp
//
//  Created by 이태윤 on 7/10/25.
//

class CalculatorViewModel: ViewModelProtocol {
  enum Action {
    case calculate(text: String)
  }

  struct State {
    var countryCode: String = ""
    var countryName: String = ""
    var rate: Double = 0.0
    var message: String = ""
    var result: String = ""
  }

  var onStateChanged: ((State) -> Void)?
  private(set) var state = State()

  init(code: String, country: String, rate: Double) {
    state.countryCode = code
    state.countryName = country
    state.rate = rate
  }

  func action(_ action: Action) {
    switch action {
      case .calculate(let text):
        calculate(text: text)
    }
  }

  func calculate(text: String?) {
    self.state.message = ""
    guard let text = text, !text.isEmpty else {
      self.state.message = "금액을 입력해주세요"
      onStateChanged?(state)
      return 
    }
    guard let amount = Double(text) else {
      self.state.message = "올바른 숫자를 입력해주세요"
      onStateChanged?(state)
      return
    }
    let formatAomunt = format2f(amount)
    let formatResult = format2f(self.state.rate * amount)
    let countryCode = self.state.countryCode
    self.state.result = "$" + formatAomunt + " → " + formatResult + " " + countryCode
    onStateChanged?(state)
    print(self.state)
  }

  private func format2f(_ value: Double) -> String {
    return String(format: "%.2f", value)
  }
}
