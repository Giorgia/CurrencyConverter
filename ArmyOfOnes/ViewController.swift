//
//  ViewController.swift
//  ArmyOfOnes
//
//  Created by Giorgia Marenda on 10/26/15.
//  Copyright © 2015 Giorgia Marenda. All rights reserved.
//

import UIKit

let reuseTableViewCellIdentifier = "Cell"

class CurrencyCell: UITableViewCell {
    
    @IBOutlet weak var amountLabel: UILabel!
    @IBOutlet weak var symbolLabel: UILabel!
}

class ViewController: UIViewController, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var textField: UITextField!
    
    let currencies  = [Currency.UK, Currency.EU, Currency.JP, Currency.BZ]
    var conversions: [Conversion?]?

    override func viewDidLoad() {
        super.viewDidLoad()

        conversions = [Conversion?](count:currencies.count, repeatedValue: nil)
        reloadAllConversions(1)
    }
    
    func loadUSDConversion(target: Currency, amount: Int) {
        CurrencyAPI.convertion(from: .US, to: target, amount: amount, completion: { (conversion, error) -> Void in
            guard
                let index = self.currencies.indexOf(target) else { return }
            self.conversions?[index] = conversion
            self.tableView.reloadRowsAtIndexPaths([NSIndexPath(forItem: index, inSection: 0)], withRowAnimation: UITableViewRowAnimation.None)
        })
    }
    
    func reloadAllConversions(amount: Int) {
        for c in currencies {
            loadUSDConversion(c, amount: amount)
        }
    }

    @IBAction func go() {
        textField.resignFirstResponder()
        if let text = textField.text, amount = Int(text) {
            reloadAllConversions(amount)
        }
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return currencies.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(reuseTableViewCellIdentifier, forIndexPath: indexPath)
       
        guard
            let currencyCell    = cell as? CurrencyCell,
            let conversion      = conversions?[indexPath.row],
            let target          = conversion.target,
            let amount          = conversion.amount,
            let currency        = Currency(rawValue: target)
            else { return cell }
        
        currencyCell.symbolLabel.text = currency.flag
        currencyCell.amountLabel.text = "\(amount) \(currency.symbol)"
    
        return currencyCell
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

