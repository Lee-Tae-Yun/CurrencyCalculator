//
//  CurrencyView.swift
//  CurrencyCalculatorApp
//
//  Created by 이태윤 on 7/7/25.
//
import UIKit
import Then

class CurrencyView: UIView {

  lazy var currencyTableView = UITableView().then {
    $0.register(CurrencyTableViewCell.self, forCellReuseIdentifier: CurrencyTableViewCell.id)
  }


  override init(frame: CGRect) {
    super.init(frame: frame)
    backgroundColor = .systemBackground
    addViewUI()
    tableViewConfigure()
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  private func addViewUI() {
    addSubview(currencyTableView)
  }

  // MARK: - TavbleView
  private func tableViewConfigure() {
    currencyTableView.snp.makeConstraints {
      $0.directionalEdges.equalTo(safeAreaLayoutGuide)
    }
  }
}


