//
//  Store.swift
//  tipsapp
//
//  Created by CK on 3/5/17.
//  Copyright © 2017 CK. All rights reserved.
//

import Foundation


class Store {
    
    static var serviceDetail:String! = "Typical Waiters around 15 - 30 % is the norm   pre - tax bill. Well !! game theory says tip , only if you prefer to come back. (You ll come back if you like it , and obviously you ll tip)"
    static var service:String = "Waiters"
    static var segmentTip:[String] = ["15%","20%","30%"]
    
    class func storeDefaultServiceDetails(serviceArg:String , serviceDetailArg:String , segmentTipArray:[String] ) {
        serviceDetail = serviceDetailArg
        service = serviceArg
        segmentTip = segmentTipArray
    }
    
    
    
}
