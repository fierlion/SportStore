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
    var productStore = ProductDataStore()

    override func viewDidLoad() {
        super.viewDidLoad()
        displayStockTotal()
        
        productStore.callback = {(p:Product) in
            for cell in self.tableView.visibleCells {
                if let pcell = cell as? ItemTableViewCell {
                    if pcell.product?.name == p.name {
                        pcell.stockStepper.value = Double(p.stockLevel)
                        pcell.stockField.text = String(p.stockLevel)
                    }
                }
            }
            self.displayStockTotal()
        }
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return productStore.products.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let product = productStore.products[indexPath.row]
        let cellIdentifier = "ItemTableViewCell"
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! ItemTableViewCell
        cell.product = product
        cell.nameLabel.text = product.name
        cell.descriptionLabel.text = product.productDescription
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
                        productLogger.logItem(product)
                    }
                    break
                }
            }
            displayStockTotal()
        }
    }
    func displayStockTotal() {
        let finalTotals:(Int,Double) = productStore.products.reduce((0, 0.0),
            combine: {(totals, product) -> (Int, Double) in
                return (
                    totals.0 + product.stockLevel,
                    totals.1 + product.stockValue
                )
            })
        
        totalStockLabel.text = "\(finalTotals.0) Products in stock"
    }
}