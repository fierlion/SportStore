//
//  ViewController.swift
//  SportsStore
//
//  Created by Ray Foote on 12/13/15.
//  Copyright © 2015 fierlion. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource {
    //MARK: Properties
    @IBOutlet weak var totalStockLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    var products = [
        ("Kayak", "a boat for one person", "watersports", 275.0, 10),
        ("Soccer Ball", "fifa approved size and weight", "soccer", 19.5, 32),
        ("stadium", "35000 seat stadium", "soccer", 79500.0, 4),
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
        displayStockTotal()
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return products.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let product = products[indexPath.row]
        let cellIdentifier = "ItemTableViewCell"
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! ItemTableViewCell
        cell.productId = indexPath.row
        cell.nameLabel.text = product.0
        cell.descriptionLabel.text = product.1
        cell.stockStepper.value = Double(product.4)
        cell.stockField.text = String(product.4)
        return cell
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func stockLevelDidChange(sender: AnyObject) {
        if var currentCell = sender as? UIView {
            while (true) {
                currentCell = currentCell.superview!
                if let cell = currentCell as? ItemTableViewCell {
                    let currentId = cell.productId
                    if currentId >= 0 {
                        var newStockLevel:Int?
                        
                        if let stepper = sender as? UIStepper {
                            newStockLevel = Int(stepper.value)
                        }
                        else if let textField = sender as? UITextField {
                            if let newValue = Int(textField.text!) {
                                newStockLevel = newValue
                            }
                        }
                        
                        if let level = newStockLevel {
                            if currentId >= 0 {
                                products[currentId!].4 = level
                            }
                            cell.stockStepper.value = Double(level)
                            cell.stockField.text = String(level)
                        }
                    }
                    break
                }
            }
            displayStockTotal()
        }
    }
    func displayStockTotal() {
        let stockTotal = products.reduce(0, combine: {(total, product) -> Int in return total + product.4})
        totalStockLabel.text = "\(stockTotal) Products in stock"
    }
}