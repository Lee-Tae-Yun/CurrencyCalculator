//
//  CurrencyViewController.swift
//  CurrencyCalculatorApp
//
//  Created by 이태윤 on 7/7/25.
//

import UIKit

class ViewController: UIViewController {
  private let currencyView = CurrencyView()
  private let currencyVM = CurrencyViewModel()

  override func loadView() {
    view = currencyView
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    // TableView, SearchBar delegate 연결
    currencyView.currencyTableView.delegate = self
    currencyView.currencyTableView.dataSource = self
    currencyView.searchBar.delegate = self

    // ViewModel 상태 변화 바인딩
    bindViewModel()

    // 데이터 로드
    currencyVM.action(.loadData)
  }

  private func bindViewModel() {
    currencyVM.onStateChanged = { [weak self] state in
      guard let self else { return }

      // 에러 메시지 표시
      if let message = state.errorMessage {
        self.showAlert(message: message)
        return
      }

      // 검색 결과 유무에 따라 라벨 표시
      self.currencyView.emptyLabel.isHidden = state.isEmptyHidden

      // 테이블 뷰 리로드
      self.currencyView.currencyTableView.reloadData()
    }
  }

  private func showAlert(message: String) {
    let alert = UIAlertController(title: "에러", message: message, preferredStyle: .alert)
    alert.addAction(UIAlertAction(title: "확인", style: .default))
    present(alert, animated: true)
  }
}

// MARK: - UITableViewDelegate
extension ViewController: UITableViewDelegate {
  // 셀을 선택했을 때
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    tableView.deselectRow(at: indexPath, animated: true)

    let item = currencyVM.item(at: indexPath)
    print("선택한 항목: \(item)")

    let calculatorVM = CalculatorViewModel(
      code: item.code,
      country: item.currencyName,
      rate: item.rate
    )
    let calculatorVC = CalculatorViewController(viewModel: calculatorVM)

    // 백버튼 제목 설정
    let backBarButton = UIBarButtonItem(title: "환율 정보", style: .plain, target: nil, action: nil)
    navigationItem.backBarButtonItem = backBarButton

    navigationController?.pushViewController(calculatorVC, animated: true)
  }

  // 셀 높이
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    60
  }
}

// MARK: - UITableViewDataSource
extension ViewController: UITableViewDataSource {
  // 섹션 개수
  func numberOfSections(in tableView: UITableView) -> Int {
    return currencyVM.numberOfSections()
  }

  // 섹션 타이틀
  func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
    return currencyVM.titleForSection(section)
  }

  // 섹션별 셀 수
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return currencyVM.numberOfItems(in: section)
  }

  // 셀 구성
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCell(withIdentifier: CurrencyTableViewCell.id, for: indexPath) as? CurrencyTableViewCell else {
      return UITableViewCell()
    }

    let item = currencyVM.item(at: indexPath)

    // 셀에 데이터 적용
    cell.configureCell(
      code: item.code,
      rate: item.rate,
      country: item.currencyName,
      isFavorite: item.isFavorite
    )

    // 즐겨찾기 버튼 눌렀을 때 처리
    cell.favoriteButtonTapped = { [weak self] in
      self?.currencyVM.action(.toggleFavorite(item.code))
    }

    return cell
  }
}

// MARK: - UISearchBarDelegate
extension ViewController: UISearchBarDelegate {
  // 검색 텍스트 변경 시 필터링
  func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
    currencyVM.action(.filter(searchText: searchText))
  }
}
