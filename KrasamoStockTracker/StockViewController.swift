//
//  StockViewController.swift
//  KrasamoStockTracker
//
//  Created by Antonio Mayorga on 2/5/19.
//  Copyright © 2019 Rays Industrial Computers. All rights reserved.
//

import UIKit

class StockViewController: UIViewController {

    let CELL_REUSE_IDENTIFIER = "stockCell"
    let USER_DEFAULT_KEY      = "stockUserDefaultsArray"
    
    @IBOutlet weak var stockTableView: UITableView!
    @IBOutlet weak var stockSymbolPopupView: UIView!
    @IBOutlet weak var dismissPopupButton: UIButton!
    @IBOutlet weak var stockPopupOkButton: UIButton!
    @IBOutlet weak var stockPopupLabel: UILabel!
    @IBOutlet weak var stockPopupTextField: UITextField!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    var stockQuotes: [Quote] = [] {
        didSet {
            stockTableView.reloadData()
            let stockSymbols = stockQuotes.map({ return $0.symbol })
            UserDefaults.standard.set(stockSymbols, forKey: USER_DEFAULT_KEY)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let darkGray = UIColor.init(displayP3Red: 35.0/255.0, green: 31.0/255.0, blue: 32.0/255.0, alpha: 1.0)
        
        stockTableView.delegate = self
        stockTableView.dataSource = self
        stockTableView.backgroundColor = darkGray
        stockTableView.tableFooterView = UIView()
        
        stockSymbolPopupView.alpha = 0.0
        dismissPopupButton.isEnabled = false
        stockPopupTextField.delegate = self
        stockPopupOkButton.layer.borderWidth = 1.0
        stockPopupOkButton.layer.borderColor = UIColor.white.cgColor
        
        navigationItem.title = "My Stocks"
        navigationController?.navigationBar.setValue(true, forKey: "hidesShadow")
        navigationController?.navigationBar.barStyle = .black
        navigationController?.navigationBar.titleTextAttributes = [
            NSAttributedString.Key.foregroundColor: UIColor.white
        ]
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.barTintColor = darkGray
        
        view.backgroundColor = darkGray
        
    }
}

extension StockViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return stockQuotes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CELL_REUSE_IDENTIFIER, for: indexPath) as! StockCell
        
        cell.stockSymbol.text = stockQuotes[indexPath.row].symbol
        cell.maximumStockPrice.text = "\(stockQuotes[indexPath.row].high ?? 0.0)"
        cell.minimumStockPrice.text = "\(stockQuotes[indexPath.row].low ?? 0.0)"
        cell.currentStockPrice.text = "\(stockQuotes[indexPath.row].latestPrice ?? 0.0)"
        
        return cell
    }
}

extension StockViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return false
    }
}
