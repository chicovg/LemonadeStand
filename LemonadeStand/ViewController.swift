//
//  ViewController.swift
//  LemonadeStand
//
//  Created by Victor Guthrie on 5/2/15.
//  Copyright (c) 2015 chicovg. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    // IBOutlets
    @IBOutlet weak var totalCashLabel: UILabel!
    @IBOutlet weak var totalLemonsLabel: UILabel!
    @IBOutlet weak var totalIceCubesLabel: UILabel!
    
    @IBOutlet weak var purchaseLemonsLabel: UILabel!
    @IBOutlet weak var purchaseIceLabel: UILabel!
    
    @IBOutlet weak var mixLemonsLabel: UILabel!
    @IBOutlet weak var mixIceCubesLabel: UILabel!
    
    @IBOutlet weak var incLemonsToPurchaseButton: UIButton!
    @IBOutlet weak var decLemonsToPurchaseButton: UIButton!
    @IBOutlet weak var incIceCubesToPurchaseButton: UIButton!
    @IBOutlet weak var decIceCubesToPurchaseButton: UIButton!
    
    @IBOutlet weak var incLemonsToMixButton: UIButton!
    @IBOutlet weak var decLemonsToMixButton: UIButton!
    @IBOutlet weak var incIceCubesToMixButton: UIButton!
    @IBOutlet weak var decIceCubesToMixButton: UIButton!
    
    @IBOutlet weak var startDayButton: UIButton!
    @IBOutlet weak var forecastImage: UIImageView!
    
    // constants
    let kLemonCost: Int = 2
    let kIceCubeCost: Int = 1
    let kLemonadePrice: Int = 1
    
    // class variables
    var totalCash: Int = 10;
    var totalLemons: Int = 1;
    var totalIceCubes: Int = 1;
    
    var lemonsToPurchase: Int = 0;
    var iceCubesToPurchase: Int = 0;
    
    var lemonsToMix: Int = 0;
    var iceCubesToMix: Int = 0;
    
    var weather: Int = 0;
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        updateView()
        updateWeather()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // IBActions
    @IBAction func incPurchaseLemons(sender: UIButton) {
        self.lemonsToPurchase++
        self.totalLemons++
        self.totalCash -= kLemonCost
        updateView()
    }
    
    @IBAction func decPurchaseLemons(sender: UIButton) {
        self.lemonsToPurchase--
        self.totalLemons--
        self.totalCash += kLemonCost
        updateView()
    }

    @IBAction func incPurchaseIceCubes(sender: UIButton) {
        self.iceCubesToPurchase++
        self.totalIceCubes++
        self.totalCash -= kIceCubeCost
        updateView()
    }
    
    @IBAction func decPurchaseIceCubes(sender: UIButton) {
        self.iceCubesToPurchase--
        self.totalIceCubes--
        self.totalCash += kIceCubeCost
        updateView()
    }
    
    @IBAction func incMixLemons(sender: UIButton) {
        self.lemonsToMix++
        self.totalLemons--
        updateView()
    }
    
    @IBAction func decMixLemons(sender: UIButton) {
        self.lemonsToMix--
        self.totalLemons++
        updateView()
    }
    
    @IBAction func incMixIceCubes(sender: UIButton) {
        self.iceCubesToMix++
        self.totalIceCubes--
        updateView()
    }
    
    
    @IBAction func decMixIceCubes(sender: UIButton) {
        self.iceCubesToMix--
        self.totalIceCubes++
        updateView()
    }
    
    @IBAction func startDayPressed(sender: UIButton) {
        var payingCustomers = LemonadeSalesEngine.sellLemonade(self.weather, lemonsToMix: lemonsToMix, iceCubesToMix: iceCubesToMix)
        totalCash += kLemonadePrice*payingCustomers
        self.lemonsToPurchase = 0
        self.iceCubesToPurchase = 0
        self.lemonsToMix = 0
        self.iceCubesToMix = 0
        updateView()
        updateWeather()
    }
    
    // helper functions
    func updateView(){
        self.totalCashLabel?.text = "$\(self.totalCash)"
        self.totalLemonsLabel?.text = "\(self.totalLemons) Lemon(s)"
        self.totalIceCubesLabel?.text = "\(self.totalIceCubes) Ice Cube(s)"
        
        self.purchaseLemonsLabel?.text = "\(self.lemonsToPurchase)"
        self.purchaseIceLabel?.text = "\(self.iceCubesToPurchase)"
        
        self.mixLemonsLabel?.text = "\(self.lemonsToMix)"
        self.mixIceCubesLabel?.text = "\(self.iceCubesToMix)"
        
        self.incLemonsToPurchaseButton?.enabled = totalCash >= kLemonCost
        self.incIceCubesToPurchaseButton?.enabled = totalCash >= kIceCubeCost
        self.incLemonsToMixButton?.enabled = totalLemons > 0
        self.incIceCubesToMixButton?.enabled = totalIceCubes > 0
        
        self.decLemonsToPurchaseButton?.enabled = lemonsToPurchase > 0
        self.decIceCubesToPurchaseButton?.enabled = iceCubesToPurchase > 0
        self.decLemonsToMixButton?.enabled = lemonsToMix > 0
        self.decIceCubesToMixButton?.enabled = iceCubesToMix > 0
        
        self.startDayButton?.enabled = lemonsToMix > 0 && iceCubesToMix > 0
    }
    
    func updateWeather(){
        self.weather = Int(arc4random_uniform(UInt32(3)))
        println("weather \(weather)")
        switch weather {
        case 0 : self.forecastImage.image = UIImage(named: "Cold")
        case 1 : self.forecastImage.image = UIImage(named: "Mild")
        default : self.forecastImage.image = UIImage(named: "Warm")
        }
    }
    
}

