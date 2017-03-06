//
//  SettingsViewController.swift
//  tipsapp
//
//  Created by CK on 3/5/17.
//  Copyright © 2017 CK. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController ,UITableViewDelegate,UITableViewDataSource {

    @IBOutlet weak var settingsTable: UITableView!
    let sections: [String] = ["Settings", "Services"]
    let appSettings: [String] = ["Theme", "Default Share", "Save History"]
    let services: [String] = ["Waiters", "Bartenders", "Car Washers" ,"Delivery" ,"Hair Salon", "Nails/Spa" , "Movers", "Massage", "Room Service/House Keeping","Gardeners","Baby Sitters"]
//    let s3Data: [String] = ["Row 1", "Row 2", "Row 3"]
    
    var sectionData: [Int: [String]] = [:]
    var serviceAndTips: [String:[String]] = [:]
    var serviceAndDescriptions: [String:String] = [:]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        settingsTable.delegate  = self
        settingsTable.dataSource = self
        sectionData = [0:appSettings , 1:services ]
        let lower : UInt32 = 5
        let upper : UInt32 = 30
        
        //randomly generating temporarily. 
        //TODO: with actual helpful tip as a service.
        for service in services {
           var numbers = [arc4random_uniform(upper - lower) + lower ,arc4random_uniform(upper - lower) + lower,arc4random_uniform(upper - lower) + lower]
           numbers.sort()
            serviceAndTips[service] = numbers.map({ (val) -> String! in
                String(val)+"%"
            })
        }
        
        for service in services {
            serviceAndDescriptions[service] = "Typical \(service) around [ \((serviceAndTips[service]?[0] )!) - \((serviceAndTips[service]?[2])!) ] is the norm   pre - tax bill. Well !! game theory says tip , only if you prefer to come back. (You ll come back if you like it , and you ll tip) "
        }
        
        let indexPath:IndexPath = IndexPath(row: 2, section: 1)
        settingsTable.selectRow(at: indexPath, animated: true, scrollPosition: UITableViewScrollPosition.bottom)
    }

    
    func sortFunc(num1: Int, num2: Int) -> Bool {
        return num1 < num2
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int)
        -> Int {
            return (sectionData[section]?.count)!
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int)
        -> String? {
            return sections[section]
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedService:String = services[indexPath.item]
        Store.storeDefaultServiceDetails(serviceArg: selectedService, serviceDetailArg: serviceAndDescriptions[selectedService]!, segmentTipArray: serviceAndTips[selectedService]!)
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 44
    }
    
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        let header:UITableViewHeaderFooterView = view as! UITableViewHeaderFooterView
        header.textLabel?.font = UIFont(name: "Avenir Next", size: 18)
        header.textLabel?.textColor = UIColor.white
        view.tintColor = UIColor.pomegranate()
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath)
        -> UITableViewCell {
            var cell = tableView.dequeueReusableCell(withIdentifier: "cell")
            
            if cell == nil {
                cell = UITableViewCell(style: .default, reuseIdentifier: "cell");
            }
            
            cell!.textLabel?.text = sectionData[indexPath.section]![indexPath.row]
            cell!.configureFlatCell(with: UIColor.white, selectedColor: UIColor.gray)
            cell!.cornerRadius = 5.0;
            cell!.separatorHeight = 1.0;
            cell!.textLabel?.font = UIFont(name: "Avenir Next", size: 16)
            
            return cell!
    }
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
