//
//  Store.swift
//  tipsapp
//
//  Created by CK on 3/5/17.
//  Copyright © 2017 CK. All rights reserved.
//

import Foundation
import UIKit

class Store {
    
    static var serviceDetail:String! = "Typical Waiters around 15 - 30 % is the norm   pre - tax bill. Well !! game theory says tip , only if you prefer to come back. (You ll come back if you like it , and obviously you ll tip)"
    static var service:String = "Waiters"
    static var segmentTip:[String] = ["15%","20%","30%"]
    
    class func storeDefaultServiceDetails(serviceArg:String , serviceDetailArg:String , segmentTipArray:[String] ) {
        serviceDetail = serviceDetailArg
        service = serviceArg
        segmentTip = segmentTipArray
    }
    
    
    class func setStyleColor(color:String) {
        let defaults = UserDefaults.standard
        defaults.set(color, forKey: "styleColor")
    }
    
    class func styleColor()->UIColor {
        let defaults = UserDefaults.standard
        let color:String! = defaults.string(forKey: "styleColor")
        if(color != nil) {
            switch color {
                case "p" : return UIColor.pomegranate()
                case "g" : return UIColor.greenSea()
                case "b" : return UIColor.belizeHole()
                default : return UIColor.pomegranate()
            }
        }
        else {
            return UIColor.pomegranate()
        }
        
    }
    
    
}
