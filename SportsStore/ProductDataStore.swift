//
//  ProductDataStore.swift
//  SportsStore
//
//  Created by Ray Foote on 12/15/15.
//  Copyright © 2015 fierlion. All rights reserved.
//

import Foundation

final class ProductDataStore {
    var callback:((Product) -> Void)?
    private var networkQ:dispatch_queue_t
    private var uiQ:dispatch_queue_t
    lazy var products:[Product] = self.loadData()
    
    init() {
        networkQ = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0)
        uiQ = dispatch_get_main_queue()
    }
    
    private func loadData() -> [Product] {
        for p in productData {
            dispatch_async(self.networkQ, {() in
                let stockConn = NetworkPool.getConnection()
                let level = stockConn.getStockLevel(p.name)
                if (level != nil) {
                    p.stockLevel = level!
                    dispatch_async(self.uiQ, {() in
                        if (self.callback != nil) {
                            self.callback!(p)
                        }
                    })
                }
                NetworkPool.returnConnection(stockConn)
            })
        }
        return productData
    }
    
    private var productData:[Product] = [
        Product(name:"Kayak", description:"a boat for one person", category:"watersports", price:275.0, stockLevel:0),
        Product(name:"Soccer Ball", description:"fifa approved size and weight", category:"soccer", price:19.5, stockLevel:0),
        Product(name:"stadium", description:"35000 seat stadium", category:"soccer", price:79500.0, stockLevel:0)
    ]
}
