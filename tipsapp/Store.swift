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
    static let defaults = UserDefaults.standard
    static var service:String = "Waiters"
    static var segmentTip:[String] = ["15%","20%","30%"]
    static let sections: [String] = ["Settings", "Services"]
    static let appSettings: [String] = ["Theme", "Save History" ,"Default Tip"]
    static let services: [String] = ["Waiters", "Bartenders", "Car Washers" ,"Delivery" ,"Hair Salon", "Nails/Spa" , "Movers", "Massage", "Room Service/House Keeping","Gardeners","Baby Sitters"]
    
    class func getService()-> String {
        let serv:String! = defaults.string(forKey: "storedService")
        if(serv != nil) {
            return serv
        }
        return "Waiters"
    }


    
    class func storeDefaultServiceDetails(serviceArg:String , serviceDetailArg:String , segmentTipArray:[String] ) {
        serviceDetail = serviceDetailArg
        service = serviceArg
        segmentTip = segmentTipArray
        
        defaults.set(service, forKey: "storedService");
    }
    
    class func storeBillAmount(amount:Float) {
        defaults.set(amount, forKey: "billAmount")
        let currentEpoch:Int = Int(floor(Date().timeIntervalSince1970 * 1000))
        defaults.set(currentEpoch, forKey: "lastUpdated")
    }
    
    
    class func billAmount()->(Float,Int) {
        return (defaults.float(forKey: "billAmount"),defaults.integer(forKey: "lastUpdated"))
    }
    
    class func setStyleColor(color:String) {
        let defaults = UserDefaults.standard
        defaults.set(color, forKey: "styleColor")
    }
    
    class func styleColor()->UIColor {
        
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
    
    class func storeDefaultTipe(defaultTip:Float) {
        defaults.set(defaultTip, forKey: "defaultTip");
    }
    
    class func defaultTip()->Float {
        return defaults.float(forKey: "defaultTip")
    }
    
}
