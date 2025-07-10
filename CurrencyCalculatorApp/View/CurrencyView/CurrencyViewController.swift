//
//  CurrencyViewController.swift
//  CurrencyCalculatorApp
//
//  Created by 이태윤 on 7/7/25.
//

import UIKit

class ViewController: UIViewController {
  private let currencyService = CurrencyService()
  private let currencyView = CurrencyView()
  private var items: [CurrencyItem] = []
  private var filteredItems: [CurrencyItem] = []
  private var base = CurrencyBase.usd

  override func loadView() {
    view = currencyView
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    currencyView.currencyTableView.delegate = self
    currencyView.currencyTableView.dataSource = self
    currencyView.searchBar.delegate = self
    loadData(for: base)
  }

  func loadData(for base: CurrencyBase) {
    currencyService.fetchCurrency(base: base) { result in
      switch result {
      case .success(let currency):
        DispatchQueue.main.async {
          self.items = currency.items
          self.filteredItems = currency.items // 초기에 전체를 보여주기
          self.currencyView.currencyTableView.reloadData()
        }
      case .failure(let error):
        print("❌ 에러 발생: \(error)")
        DispatchQueue.main.async {
          let alert = UIAlertController(title: "Error", message: "데이터를 불러오지 못했습니다.", preferredStyle: .alert)
          alert.addAction(UIAlertAction(title: "확인", style: .default))
          self.present(alert, animated: true)
        }
      }
    }
  }
}

extension ViewController: UITableViewDelegate {
  // 셀을 선택했을 때
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    print("선택한 항목: \(filteredItems[indexPath.row])")
    // 셀 선택 시 계산기 뷰컨트롤러 생성
    let calculatorVC = CalculatorViewController()

    calculatorVC.countryCode = filteredItems[indexPath.row].code
    calculatorVC.countryName = CountryModel.countryList[filteredItems[indexPath.row].code] ?? "국가명 없음"
    calculatorVC.rate = filteredItems[indexPath.row].rate

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
    return filteredItems.count
  }
  // 각셀에 어떤 데이터를 넣을껀지.
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCell(withIdentifier: CurrencyTableViewCell.id, for: indexPath) as? CurrencyTableViewCell else {
      return UITableViewCell()
    }

    let item = filteredItems[indexPath.row]
    let countryName = CountryModel.countryList[item.code] ?? "국가명 없음"

    cell.configureCell(code: item.code, rate: item.rate, country: countryName)
    return cell
  }
}

extension ViewController: UISearchBarDelegate {
  // 서치바에 입력한 텍스트가 변경될 때 호출
  func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
    if searchText.isEmpty {
      filteredItems = items
    } else {
      filteredItems = items.filter { item in
        let codeMatch = item.code.lowercased().contains(searchText.lowercased())
        let countryMatch = CountryModel.countryList[item.code]?.contains(searchText) ?? false
        return codeMatch || countryMatch
      }
    }
    currencyView.emptyLabel.isHidden = !(filteredItems.isEmpty && !searchText.isEmpty)
    currencyView.currencyTableView.reloadData()
  }
}
