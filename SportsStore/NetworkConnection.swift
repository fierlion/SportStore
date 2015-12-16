//
//  NetworkConnection.swift
//  SportsStore
//
//  Created by Ray Foote on 12/15/15.
//  Copyright © 2015 fierlion. All rights reserved.
//

import Foundation

class NetworkConnection {
    
    private let stockData: [String: Int] = [
        "kayak": 10, "Lifejacket": 4, "soccer ball": 32
    ]
    
    func getStockLevel(name:String) -> Int? {
        NSThread.sleepForTimeInterval(Double(rand() % 2))
        if let result = stockData[name] {
            return result
        }
        else {
            return -1
        }
    }


}
