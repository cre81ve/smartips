//
//  DefaultTipCell.swift
//  tipsapp
//
//  Created by CK on 3/11/17.
//  Copyright © 2017 CK. All rights reserved.
//

import UIKit

class DefaultTipCell: UITableViewCell  {

    @IBOutlet weak var defaultTipPercent: UITextField!
    var tipPercent:Float = 0
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        if(Store.defaultTip() != 0 ){
            defaultTipPercent.text = String(Int(Store.defaultTip()))
        }
        // Configure the view for the selected state
    }
   }
