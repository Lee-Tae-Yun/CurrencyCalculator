//
//  CurrencyView.swift
//  CurrencyCalculatorApp
//
//  Created by 이태윤 on 7/7/25.
//
import UIKit
import Then

class CurrencyView: UIView {
  private let titleLabel = UILabel().then {
    $0.font = .systemFont(ofSize: 30, weight: .bold)
    $0.text = "환율 정보"
  }
  // 검색바 통화 코드 또는 국가명 입력용
  let searchBar = UISearchBar().then {
    $0.placeholder = "통화 검색"
  }
  // 통화 리스트를 보여줄 테이블뷰
  lazy var currencyTableView = UITableView().then {
    $0.register(CurrencyTableViewCell.self, forCellReuseIdentifier: CurrencyTableViewCell.id)
    $0.showsVerticalScrollIndicator = false
  }
  
  let emptyLabel = UILabel().then {
    $0.text = "검색 결과가 없습니다"
    $0.textAlignment = .center
    $0.textColor = .systemGray
    $0.isHidden = true
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
  // View에 서브뷰 추가
  private func addViewUI() {
    [titleLabel, searchBar ,currencyTableView, emptyLabel].forEach { addSubview($0) }
  }
  
  // MARK: - 제약 설정
  private func setConfigureUI() {
    titleLabel.snp.makeConstraints {
      $0.top.equalTo(safeAreaLayoutGuide)
      $0.leading.equalTo(safeAreaLayoutGuide).inset(24)
    }
    
    searchBar.snp.makeConstraints {
      $0.top.equalTo(titleLabel.snp.bottom).offset(8)
      $0.leading.trailing.equalToSuperview()
    }
    
    currencyTableView.snp.makeConstraints {
      $0.top.equalTo(searchBar.snp.bottom).offset(8)
      $0.leading.trailing.equalTo(safeAreaLayoutGuide)
      $0.bottom.equalToSuperview()
    }
    
    emptyLabel.snp.makeConstraints {
      $0.centerX.equalTo(currencyTableView)
      $0.centerY.equalTo(currencyTableView)
      $0.leading.trailing.equalTo(currencyTableView).inset(16)
    }
  }
}

