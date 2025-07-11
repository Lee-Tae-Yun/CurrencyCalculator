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

  private let countrycodeStackView = UIStackView().then {
    $0.axis = .vertical
    $0.spacing = 4
  }
  private let codeLabel = UILabel().then {
    $0.font = .systemFont(ofSize: 16)
  }
  private let countryLabel = UILabel().then {
    $0.font = .systemFont(ofSize: 14, weight: .medium)
    $0.textColor = .systemGray
  }
  private let rateLabel = UILabel().then {
    $0.font = .systemFont(ofSize: 16)
  }

  private let favoriteButton = UIButton().then {
    $0.tintColor = .systemBlue
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
    [countrycodeStackView, favoriteButton, rateLabel].forEach { contentView.addSubview($0) }
    [codeLabel, countryLabel].forEach { countrycodeStackView.addArrangedSubview($0) }
  }
  private func cellConstaints() {
    countrycodeStackView.snp.makeConstraints {
      $0.leading.equalToSuperview().inset(16)
      $0.centerY.equalToSuperview()
    }
    rateLabel.snp.makeConstraints {
      $0.leading.greaterThanOrEqualTo(countrycodeStackView.snp.trailing).offset(16)
      $0.trailing.equalTo(favoriteButton.snp.leading).offset(-16)
      $0.centerY.equalToSuperview()
    }
    favoriteButton.snp.makeConstraints {
      $0.trailing.equalToSuperview().inset(16)
      $0.centerY.equalToSuperview()
    }
  }

  func configureCell(code: String, rate: Double, country: String, isFavorite: Bool) {
    codeLabel.text = code
    countryLabel.text = country
    rateLabel.text = String(format: "%.4f", rate)

    let starImage = isFavorite ? "star.fill" : "star"
    favoriteButton.setImage(UIImage(systemName: starImage), for: .normal)
  }
}
