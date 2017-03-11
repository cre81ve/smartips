//
//  Styles.swift
//  tipsapp
//
//  Created by CK on 3/5/17.
//  Copyright © 2017 CK. All rights reserved.
//

import Foundation
import UIKit
import FlatUIKit

extension UIColor {
    var coreImageColor: CIColor {
        return CIColor(color: self)
    }
    var components: (red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat) {
        let color = coreImageColor
        return (color.red, color.green, color.blue, color.alpha)
    }
}

class Styles {
    
    class func themeColor()->UIColor {
        return Store.styleColor()
    }
    
    class func styleText(tf:FUITextField)  {
        //text style
        tf.font = UIFont.flatFont(ofSize: 16)
        tf.textFieldColor = UIColor.white
        tf.borderColor = UIColor.turquoise()
        tf.borderWidth = 2.0
        tf.cornerRadius = 3.0
    }

    class func styleSlider(slider:UISlider)  {
        slider.isContinuous = true
        slider.configureFlatSlider(withTrackColor: UIColor.silver(), progressColor: Styles.themeColor(), thumbColor: Styles.themeColor())

    }


    class func styleSegmentControl(segmentControl:FUISegmentedControl)  {
        segmentControl.selectedFont = UIFont.boldFlatFont(ofSize: 16)
        segmentControl.selectedFontColor = UIColor.clouds()
        segmentControl.deselectedFont = UIFont.flatFont(ofSize: 16)
        segmentControl.deselectedFontColor = UIColor.darkGray
        segmentControl.selectedColor = Styles.themeColor()
        segmentControl.deselectedColor = UIColor.clouds()
        segmentControl.dividerColor = UIColor.midnightBlue()
        segmentControl.cornerRadius = 5.0;

    }
    
    class func styleNav(controller:UIViewController) {
        controller.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName : Styles.themeColor()]
        controller.navigationItem.backBarButtonItem?.tintColor = Styles.themeColor()
        controller.navigationItem.backBarButtonItem?.setTitleTextAttributes([NSForegroundColorAttributeName : Styles.themeColor()]
            , for: UIControlState.normal)
        controller.navigationItem.rightBarButtonItem?.setTitleTextAttributes([NSForegroundColorAttributeName : Styles.themeColor()]
            , for: UIControlState.normal)
    }

    class func styleLabels(label:UILabel)  {
        
    }
    
    
    
    class func darkerColorForColor(c:UIColor) -> UIColor
    {
        let redColor = c.components.red
        let greenColor = c.components.green
        let blueColor = c.components.blue
        let alpha = c.components.alpha
        return UIColor(colorLiteralRed: max(Float(redColor) - 0.2,0.0), green: max(Float(greenColor) - 0.2,0.0), blue: max(Float(blueColor) - 0.2,0.0), alpha: Float(alpha))
    }
}
