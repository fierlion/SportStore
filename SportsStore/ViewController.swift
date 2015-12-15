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
        Product(name:"Kayak", description:"a boat for one person", category:"watersports", price:275.0, stockLevel:10),
        Product(name:"Soccer Ball", description:"fifa approved size and weight", category:"soccer", price:19.5, stockLevel:32),
        Product(name:"stadium", description:"35000 seat stadium", category:"soccer", price:79500.0, stockLevel:4),
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
        cell.product = products[indexPath.row]
        cell.nameLabel.text = product.name
        cell.descriptionLabel.text = product.description
        cell.stockStepper.value = Double(product.stockLevel)
        cell.stockField.text = String(product.stockLevel)
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
                    if let product = cell.product {
                        if let stepper = sender as? UIStepper {
                            product.stockLevel = Int(stepper.value)
                        }
                        else if let textField = sender as? UITextField {
                            if let newValue = Int(textField.text!) {
                                product.stockLevel = newValue
                            }
                        }
                        cell.stockStepper.value = Double(product.stockLevel)
                        cell.stockField.text = String(product.stockLevel)
                    }
                    break
                }
            }
            displayStockTotal()
        }
    }
    func displayStockTotal() {
        let stockTotal = products.reduce(0, combine: {(total, product) -> Int in return total + product.stockLevel})
        totalStockLabel.text = "\(stockTotal) Products in stock"
    }
}