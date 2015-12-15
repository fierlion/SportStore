//
//  Product.swift
//  SportsStore
//
//  Created by Ray Foote on 12/14/15.
//  Copyright © 2015 fierlion. All rights reserved.
//

import Foundation

class Product : NSObject, NSCopying {
    
    // private(set): a property can be read from code in sibling modules, but can only be set
    // locally
    private(set) var name:String
    private(set) var productDescription:String
    private(set) var category:String
    private var stockLevelBackingValue:Int = 0
    private var priceBackingValue:Double = 0
    
    init(name:String, description:String, category:String, price:Double, stockLevel:Int) {
        self.name = name
        self.productDescription = description
        self.category = category
        
        super.init()
        
        self.price = price
        self.stockLevel = stockLevel
    }
    
    var stockLevel:Int {
        get { return stockLevelBackingValue }
        set { stockLevelBackingValue = max(0, newValue) }
    }
    
    private(set) var price:Double {
        get { return priceBackingValue }
        set { priceBackingValue = max(1, newValue) }
    }
    
    var stockValue:Double {
        get {  return price * Double(stockLevel) }
    }
    
    func copyWithZone(zone:NSZone) -> AnyObject {
        return Product(name:self.name, description: self.productDescription,
            category: self.category, price: self.price, stockLevel: self.stockLevel)
    }
    
}