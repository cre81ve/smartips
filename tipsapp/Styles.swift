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

class Styles {
    
    
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
        slider.configureFlatSlider(withTrackColor: UIColor.silver(), progressColor: UIColor.alizarin(), thumbColor: UIColor.pomegranate())

    }


    class func styleSegmentControl(segmentControl:FUISegmentedControl)  {
        segmentControl.selectedFont = UIFont.boldFlatFont(ofSize: 16)
        segmentControl.selectedFontColor = UIColor.clouds()
        segmentControl.deselectedFont = UIFont.flatFont(ofSize: 16)
        segmentControl.deselectedFontColor = UIColor.darkGray
        segmentControl.selectedColor = UIColor.pomegranate()
        segmentControl.deselectedColor = UIColor.clouds()
        segmentControl.dividerColor = UIColor.midnightBlue()
        segmentControl.cornerRadius = 5.0;

    }

    class func styleLabels(label:UILabel)  {
        
    }
}
