//
//  StockDataSource.swift
//  KrasamoStockTracker
//
//  Created by Antonio Mayorga on 2/6/19.
//  Copyright © 2019 Rays Industrial Computers. All rights reserved.
//

import UIKit

class StockDataSource: NSObject, UITableViewDataSource {
    
    let CELL_REUSE_IDENTIFIER = "stockCell"
    let USER_DEFAULT_KEY      = "stockUserDefaultsArray"
    
    var stockQuotes: [Quote] = [] {
        didSet {
            stockQuotes = stockQuotes.sorted(by: { $0.symbol! < $1.symbol! })
            let stockSymbols = stockQuotes.map({ return $0.symbol })
            UserDefaults.standard.set(stockSymbols, forKey: USER_DEFAULT_KEY)
        }
    }
    
    func addStockQuote(_ quote: Quote) {
        stockQuotes.append(quote)
    }
    
    func removeAllStockQuotes() {
        stockQuotes.removeAll()
    }
    
    func checkIfDuplicatedSymbol(_ stockSymbol: String) -> Bool {
        if let stockArray = UserDefaults.standard.array(forKey: USER_DEFAULT_KEY) {
            for symbol in stockArray as! [String] {
                if symbol.uppercased() == stockSymbol.uppercased() {
                    return true
                }
            }
        }
        return false
    }
    
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
