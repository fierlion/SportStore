//
//  ViewController.swift
//  SportsStore
//
//  Created by Ray Foote on 12/13/15.
//  Copyright © 2015 fierlion. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    //MARK: Properties
    
    @IBOutlet weak var totalStockLabel: UILabel!
    
    
    var products = [
        ("Kayak", "a boat for one person", "watersports", 275.0, 10),
        ("Soccer Ball", "fifa approved size and weight", "soccer", 19.5, 32),
        ("stadium", "35000 seat stadium", "soccer", 79500.0, 4),
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
        displayStockTotal()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func displayStockTotal() {
        let stockTotal = products.reduce(0, combine: {(total, product) -> Int in return total + product.4})
        totalStockLabel.text = "\(stockTotal) Products in stock"
    }
}