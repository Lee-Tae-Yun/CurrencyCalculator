//
//  CalculatorView.swift
//  CurrencyCalculatorApp
//
//  Created by 이태윤 on 7/10/25.
//
import UIKit
import SnapKit
import Then

class CalculatorView: UIView {
  private let codecountryStrackView = UIStackView().then {
    $0.spacing = 4
    $0.axis = .vertical
    $0.alignment = .center
  }
  private let codeLabel = UILabel().then {
    $0.font = .systemFont(ofSize: 24, weight: .bold)
  }
  private let countryLabel = UILabel().then {
    $0.font = .systemFont(ofSize: 16)
    $0.textColor = .systemGray
  }
  private let amountTextField = UITextField().then {
    $0.borderStyle = .roundedRect
    $0.keyboardType = .decimalPad
    $0.textAlignment = .center
    $0.placeholder = "금액을 입력하세요"
  }
  private let convertButton = UIButton(type: .system).then {
    $0.setTitle("환율 계산", for: .normal)
    $0.titleLabel?.font = .systemFont(ofSize: 16, weight: .medium)
    $0.backgroundColor = .systemBlue
    $0.layer.cornerRadius = 8
    $0.tintColor = .white
  }
  private let resultLabel = UILabel().then {
    $0.text = "계산 결과가 여기에 표시됩니다."
    $0.textAlignment = .center
    $0.font = .systemFont(ofSize: 20, weight: .medium)
    $0.numberOfLines = 0
  }


  override init(frame: CGRect) {
    super.init(frame: frame)
    backgroundColor = .systemBackground
    addViewUI()
    setConfigureUI()
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  private func addViewUI() {
    [codecountryStrackView, amountTextField, convertButton, resultLabel].forEach { addSubview($0) }
    [codeLabel, countryLabel].forEach { codecountryStrackView.addArrangedSubview($0)}
  }

  private func setConfigureUI() {
    codecountryStrackView.snp.makeConstraints {
      $0.top.equalTo(safeAreaLayoutGuide).inset(32)
      $0.centerX.equalToSuperview()
    }

    amountTextField.snp.makeConstraints {
      $0.top.equalTo(codecountryStrackView.snp.bottom).offset(32)
      $0.leading.trailing.equalToSuperview().inset(24)
      $0.height.equalTo(44)
    }

    convertButton.snp.makeConstraints {
      $0.top.equalTo(amountTextField.snp.bottom).offset(24)
      $0.leading.trailing.equalToSuperview().inset(24)
      $0.height.equalTo(44)
    }

    resultLabel.snp.makeConstraints {
      $0.top.equalTo(convertButton.snp.bottom).offset(32)
      $0.leading.trailing.equalToSuperview().inset(24)
    }
  }

  func calcuatorConfigure(code: String, country: String) {
    codeLabel.text = code
    countryLabel.text = country
  }
}

