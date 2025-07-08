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
    $0.font = .systemFont(ofSize: 17, weight: .medium)
  }
  private let rateLabel = UILabel().then {
    $0.font = .systemFont(ofSize: 17, weight: .medium)
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
    [codeLabel, rateLabel].forEach { contentView.addSubview($0) }
  }
  private func cellConstaints() {
    codeLabel.snp.makeConstraints {
      $0.leading.equalToSuperview().offset(16)
      $0.centerY.equalToSuperview()
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
