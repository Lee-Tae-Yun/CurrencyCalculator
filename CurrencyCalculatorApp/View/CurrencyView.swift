//
//  CurrencyView.swift
//  CurrencyCalculatorApp
//
//  Created by 이태윤 on 7/7/25.
//
import UIKit
import Then

class CurrencyView: UIView {
  let serchBar = UISearchBar()

  lazy var currencyTableView = UITableView().then {
    $0.register(CurrencyTableViewCell.self, forCellReuseIdentifier: CurrencyTableViewCell.id)
  }

  override init(frame: CGRect) {
    super.init(frame: frame)
    backgroundColor = .systemBackground
    addViewUI()
    serchBarConfigure()
    tableViewConfigure()
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  private func addViewUI() {
    [serchBar ,currencyTableView].forEach { addSubview($0) }
  }

  // MARK: - SerchchBar
  private func serchBarConfigure() {
    serchBar.snp.makeConstraints {
      $0.top.equalTo(safeAreaLayoutGuide)
      $0.leading.trailing.equalToSuperview()
    }
  }

  // MARK: - TavbleView
  private func tableViewConfigure() {
    currencyTableView.snp.makeConstraints {
      $0.top.equalTo(serchBar.snp.bottom).offset(8)
      $0.leading.trailing.equalTo(safeAreaLayoutGuide)
      $0.bottom.equalToSuperview()
    }
  }
}


