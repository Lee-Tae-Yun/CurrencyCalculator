//
//  CalculatorViewController.swift
//  CurrencyCalculatorApp
//
//  Created by 이태윤 on 7/10/25.
//
import UIKit

class CalculatorViewController: UIViewController {
  let calculator = CalculatorView()

  override func loadView() {
    view = calculator
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    
  }
}
