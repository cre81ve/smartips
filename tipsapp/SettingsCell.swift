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
        pomegranate.layer.borderColor = UIColor.pomegranate().cgColor
        greenSea.layer.borderColor = UIColor.greenSea().cgColor
        belizeHole.layer.borderColor = UIColor.belizeHole().cgColor

        if(color == nil) {
            Store.setStyleColor(color: "p")
            pomegranate.layer.borderColor = Styles.darkerColorForColor(c: UIColor.pomegranate()).cgColor

        }
        else {
            switch color {
            case "p" :  pomegranate.layer.borderColor = Styles.darkerColorForColor(c: UIColor.pomegranate()).cgColor
            case "g" :  greenSea.layer.borderColor = Styles.darkerColorForColor(c: UIColor.greenSea()).cgColor
            case "b" :  belizeHole.layer.borderColor = Styles.darkerColorForColor(c: UIColor.belizeHole()).cgColor
            default :  pomegranate.layer.borderColor = Styles.darkerColorForColor(c: UIColor.pomegranate()).cgColor
            }
        }
        
        greenSea.layer.borderWidth = 3.0
        pomegranate.layer.borderWidth = 3.0
        belizeHole.layer.borderWidth = 3.0

        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBAction func gs(_ sender: Any) {
        greenSea.layer.borderColor = Styles.darkerColorForColor(c: UIColor.greenSea()).cgColor
        pomegranate.layer.borderColor = UIColor.pomegranate().cgColor
        belizeHole.layer.borderColor = UIColor.belizeHole().cgColor
        Store.setStyleColor(color: "g")
    }
    
    
    @IBAction func pom(_ sender: Any) {
        greenSea.layer.borderColor = UIColor.greenSea().cgColor
        pomegranate.layer.borderColor = Styles.darkerColorForColor(c: UIColor.pomegranate()).cgColor
        belizeHole.layer.borderColor = UIColor.belizeHole().cgColor
        Store.setStyleColor(color: "p")

    }

    @IBAction func blz(_ sender: Any) {
        greenSea.layer.borderColor = UIColor.greenSea().cgColor
        pomegranate.layer.borderColor = UIColor.pomegranate().cgColor
        belizeHole.layer.borderColor = Styles.darkerColorForColor(c: UIColor.belizeHole()).cgColor
        belizeHole.layer.borderWidth = 3.0
        Store.setStyleColor(color: "b")

    }
}
