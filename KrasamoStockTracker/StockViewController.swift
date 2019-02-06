//
//  StockViewController.swift
//  KrasamoStockTracker
//
//  Created by Antonio Mayorga on 2/5/19.
//  Copyright © 2019 Rays Industrial Computers. All rights reserved.
//

import UIKit

class StockViewController: UIViewController {

    @IBOutlet weak var stockTableView: UITableView!
    @IBOutlet weak var stockSymbolPopupView: UIView!
    @IBOutlet weak var dismissPopupButton: UIButton!
    @IBOutlet weak var stockPopupOkButton: UIButton!
    @IBOutlet weak var stockPopupLabel: UILabel!
    @IBOutlet weak var stockPopupTextField: UITextField!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        
        let darkGray = UIColor.init(displayP3Red: 35.0/255.0, green: 31.0/255.0, blue: 32.0/255.0, alpha: 1.0)
        
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
