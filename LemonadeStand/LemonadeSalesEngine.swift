//
//  LemonadeSalesEngine.swift
//  LemonadeStand
//
//  Created by Victor Guthrie on 5/3/15.
//  Copyright (c) 2015 chicovg. All rights reserved.
//

import Foundation

class LemonadeSalesEngine {
    
    // enum representing the acidity of lemonade
    enum MixType {
        case Acidic
        case Equal
        case Diluted
        
        func desc() -> String {
            switch self {
            case .Acidic:
                return "Acidic < 1.0"
            case .Equal:
                return "Equal 1.0"
            default:
                return "Diluted > 1.0"
            }
        }
    }
    
    class func sellLemonade(weather: Int, lemonsToMix: Int, iceCubesToMix: Int) -> Int {
        let mixType = mixLemonade(lemonsToMix, iceCubesToMix: iceCubesToMix)
        let customers = CustomerFactory.generateRandomCustomers(getWeatherModifier(weather))
        
        println("Mix type: \(mixType.desc())")
        var payingCustomers = 0;
        
        for cust in customers {
            if customerLikesMix(cust.taste, mixtype: mixType) {
                println("Customer: \(cust.id), taste: \(cust.taste). Paid!")
                payingCustomers++
            } else {
                println("Customer: \(cust.id), taste: \(cust.taste). No match, No Revenue.")
            }
        }
        
        return payingCustomers
    }
    
    class func mixLemonade(lemonsToMix: Int, iceCubesToMix: Int) -> MixType {
        let ratio = Double(lemonsToMix) / Double(iceCubesToMix)
        if ratio < 1.0 {
            return MixType.Diluted
        } else if ratio == 1.0 {
            return MixType.Equal
        } else {
            return MixType.Acidic
        }
    }
    
    class func customerLikesMix(customerTaste: Double, mixtype: MixType) -> Bool {
        switch mixtype {
        case MixType.Acidic:
            return customerTaste <= 0.4
        case MixType.Equal:
            return customerTaste > 0.4 && customerTaste <= 0.6
        default:
            return customerTaste > 0.6 && customerTaste <= 1
        }
    }
    
    class func getWeatherModifier(weather: Int) -> Int {
        switch weather {
        case 0 : return -3
        case 1 : return 0
        default : return 4
        }
    }
    
}