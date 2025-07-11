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
    currencyView.currencyTableView.delegate = self
    currencyView.currencyTableView.dataSource = self
    currencyView.searchBar.delegate = self
    bindViewModel()
    currencyVM.action(.loadData)
  }

  private func bindViewModel() {
    currencyVM.onStateChanged = { [weak self] state in
      guard let self else { return }

      if let message = state.errorMessage {
        self.showAlert(message: message)
        return
      }
      self.currencyView.emptyLabel.isHidden = currencyVM.state.isEmptyHidden
      self.currencyView.currencyTableView.reloadData()
    }
  }

  private func showAlert(message: String) {
    let alert = UIAlertController(title: "에러", message: message, preferredStyle: .alert)
    alert.addAction(UIAlertAction(title: "확인", style: .default))
    present(alert, animated: true)
  }
}

extension ViewController: UITableViewDelegate {
  // 셀을 선택했을 때
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    print("선택한 항목: \(currencyVM.state.filteredItems[indexPath.row])")
    // 셀 선택 시 계산기 뷰 모델 생성
    let item = currencyVM.state.filteredItems[indexPath.row]
    let calculatorVM = CalculatorViewModel(
      code: item.code,
      country: item.currencyName,
      rate: item.rate
    )
    let calculatorVC = CalculatorViewController(viewModel: calculatorVM)
    // Back버튼 설정
    let backBarButton = UIBarButtonItem(title: "환율 정보", style: .plain, target: nil, action: nil)
    navigationItem.backBarButtonItem = backBarButton

    // navigationController가 있다면 push로 전환
    navigationController?.pushViewController(calculatorVC, animated: true)
  }
  // 셀의 높이
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    60
  }
}

extension ViewController: UITableViewDataSource {
  // 총 몇줄인지
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return currencyVM.state.filteredItems.count
  }
  // 각셀에 어떤 데이터를 넣을껀지.
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCell(withIdentifier: CurrencyTableViewCell.id, for: indexPath) as? CurrencyTableViewCell else {
      return UITableViewCell()
    }

    let item = currencyVM.state.filteredItems[indexPath.row]

    cell.configureCell(code: item.code, rate: item.rate, country: item.currencyName)
    return cell
  }
}

extension ViewController: UISearchBarDelegate {
  // 서치바에 입력한 텍스트가 변경될 때 호출
  func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
    currencyVM.action(.filter(searchText: searchText))
  }
}
