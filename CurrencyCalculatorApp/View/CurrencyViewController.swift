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
  private var base = CurrencyBase.usd

  override func loadView() {
    view = currencyView
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    currencyView.currencyTableView.delegate = self
    currencyView.currencyTableView.dataSource = self
    loadData(for: base)
  }

  func loadData(for base: CurrencyBase) {
    currencyService.fetchCurrency(base: base) { result in
      switch result {
      case .success(let currency):
        DispatchQueue.main.async {
          self.items = currency.items
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
    print("선택한 항목: \(items[indexPath.row])")
  }
  // 테이블 뷰 셀의 높이 크기 지정.
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    60
  }
}

extension ViewController: UITableViewDataSource {
  // 각셀에 어떤 데이터를 넣을껀지.
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCell(withIdentifier: CurrencyTableViewCell.id, for: indexPath) as? CurrencyTableViewCell else { return UITableViewCell() }
    let item = items[indexPath.row]
    cell.configureCell(code: item.code, rate: item.rate, country: CountryModel.countryList[item.code] ?? "국가명 없음")
    return cell
  }
  // 총 몇줄인지
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return items.count
  }
}
