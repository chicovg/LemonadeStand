//
//  CustomerFactory.swift
//  LemonadeStand
//
//  Created by Victor Guthrie on 5/2/15.
//  Copyright (c) 2015 chicovg. All rights reserved.
//

import Foundation

class CustomerFactory {
    
    // generates a list of randomly generated customers
    class func generateRandomCustomers(modifier: Int) -> [Customer] {
        var customers: [Customer] = []
        
        // create a random number of customers (up to 10)
        let numCustomers = Int(arc4random_uniform(UInt32(9))+1) + modifier
        
        for cust in 0..<numCustomers {
            var c: Customer = Customer()
            c.id = cust
            c.taste = randomTasteValue()
            customers.append(c)
        }
        
        return customers
    }
    
    class func randomTasteValue() -> Double {
        return Double(arc4random()) / 0xFFFFFFFF
    }
    
    
}