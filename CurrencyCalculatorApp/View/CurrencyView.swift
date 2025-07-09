//
//  CurrencyView.swift
//  CurrencyCalculatorApp
//
//  Created by 이태윤 on 7/7/25.
//
import UIKit
import Then

class CurrencyView: UIView {
  // 검색바 통화 코드 또는 국가명 입력용
  let searchBar = UISearchBar().then {
    $0.placeholder = "통화 검색"
  }
  // 통화 리스트를 보여줄 테이블뷰
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
  // View에 서브뷰 추가
  private func addViewUI() {
    [searchBar ,currencyTableView].forEach { addSubview($0) }
  }

  // MARK: - SearchBar 제약 설정
  private func serchBarConfigure() {
    searchBar.snp.makeConstraints {
      $0.top.equalTo(safeAreaLayoutGuide)
      $0.leading.trailing.equalToSuperview()
    }
  }

  // MARK: - TableView 제약 설정
  private func tableViewConfigure() {
    currencyTableView.snp.makeConstraints {
      $0.top.equalTo(searchBar.snp.bottom).offset(8)
      $0.leading.trailing.equalTo(safeAreaLayoutGuide)
      $0.bottom.equalToSuperview()
    }
  }
}


