//
//  ShareCell.swift
//  tipsapp
//
//  Created by CK on 3/7/17.
//  Copyright © 2017 CK. All rights reserved.
//

import UIKit

class ShareCell: UITableViewCell {

    @IBOutlet weak var saveSwitch: UISwitch!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        saveSwitch.tintColor = Styles.themeColor()
        saveSwitch.onTintColor = Styles.themeColor()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBAction func switched(_ sender: UISwitch) {
        if(sender.isOn){
            //TODO:
        }
    }
}
