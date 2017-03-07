//
//  SettingsCell.swift
//  tipsapp
//
//  Created by CK on 3/6/17.
//  Copyright © 2017 CK. All rights reserved.
//

import UIKit

class SettingsCell: UITableViewCell {

    @IBOutlet weak var rowLabel: UILabel!
    
    @IBOutlet weak var belizeHole: UIButton!
    @IBOutlet weak var pomegranate: UIButton!
    @IBOutlet weak var greenSea: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
//        self.backgroundColor = UIColor.alizarin()
        belizeHole.backgroundColor = UIColor.belizeHole()
        pomegranate.backgroundColor = UIColor.pomegranate()
        greenSea.backgroundColor = UIColor.greenSea()
       
        let defaults = UserDefaults.standard
        let color:String! = defaults.string(forKey: "styleColor")
        if(color == nil) {
            Store.setStyleColor(color: "p")
        }
        else {
            switch color {
            case "p" :  pomegranate.setTitle("*", for: UIControlState.normal)
            case "g" :  greenSea.setTitle("*", for: UIControlState.normal)
            case "b" :  belizeHole.setTitle("*", for: UIControlState.normal)
            default :  pomegranate.setTitle("*", for: UIControlState.normal)
            }
        }
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBAction func gs(_ sender: Any) {
        greenSea.setTitle("*", for: UIControlState.normal)
        pomegranate.setTitle("", for: UIControlState.normal)
        belizeHole.setTitle("", for: UIControlState.normal)
        Store.setStyleColor(color: "g")
    }
    @IBAction func pom(_ sender: Any) {
        greenSea.setTitle("", for: UIControlState.normal)
        pomegranate.setTitle("*", for: UIControlState.normal)
        belizeHole.setTitle("", for: UIControlState.normal)
        Store.setStyleColor(color: "p")

    }

    @IBAction func blz(_ sender: Any) {
        greenSea.setTitle("", for: UIControlState.normal)
        pomegranate.setTitle("", for: UIControlState.normal)
        belizeHole.setTitle("*", for: UIControlState.normal)
        Store.setStyleColor(color: "b")

    }
}
