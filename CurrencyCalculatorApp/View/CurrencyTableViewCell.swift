//
//  CurrencyTableViewCell.swift
//  CurrencyCalculatorApp
//
//  Created by 이태윤 on 7/8/25.
//

import UIKit
import Then
import SnapKit

class CurrencyTableViewCell: UITableViewCell {
  static let id = "CurrencyTableViewCell"
  
  private let codeLabel = UILabel().then {
    $0.font = .systemFont(ofSize: 15, weight: .bold)
  }
  private let rateLabel = UILabel().then {
    $0.font = .systemFont(ofSize: 15, weight: .bold)
  }
  private let countryLabel = UILabel().then {
    $0.font = .systemFont(ofSize: 15, weight: .medium)
    $0.text = "asd"
    $0.textColor = .systemGray
  }

  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    addViewUI()
    cellConstaints()
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  private func addViewUI() {
    [codeLabel, rateLabel, countryLabel].forEach { contentView.addSubview($0) }
  }
  private func cellConstaints() {
    codeLabel.snp.makeConstraints {
      $0.top.equalToSuperview().inset(5)
      $0.leading.equalToSuperview().offset(16)
    }
    countryLabel.snp.makeConstraints {
      $0.top.equalTo(codeLabel.snp.bottom).offset(5)
      $0.leading.equalToSuperview().inset(16)
      
    }
    rateLabel.snp.makeConstraints {
      $0.trailing.equalToSuperview().inset(16)
      $0.centerY.equalToSuperview()
    }
  }

  func configureCell(code: String, rate: Double) {
    codeLabel.text = code
    rateLabel.text = String(format: "%.4f", rate)
  }
}
