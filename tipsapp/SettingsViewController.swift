//
//  SettingsViewController.swift
//  tipsapp
//
//  Created by CK on 3/5/17.
//  Copyright © 2017 CK. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController ,UITableViewDelegate,UITableViewDataSource ,UITextFieldDelegate {

    @IBOutlet weak var settingsTable: UITableView!
    @IBOutlet weak var defaultTipPercent: UITextField!

    var sectionData: [Int: [String]] = [:]
    var serviceAndTips: [String:[String]] = [:]
    var serviceAndDescriptions: [String:String] = [:]
    override func viewDidLoad() {
        super.viewDidLoad()
        settingsTable.delegate  = self
        settingsTable.dataSource = self
        
        sectionData = [0:Store.appSettings , 1:Store.services ]
        let lower : UInt32 = 5
        let upper : UInt32 = 30
        
        //randomly generating temporarily. 
        //TODO: with actual helpful tip as a service.
        for service in Store.services {
           var numbers = [arc4random_uniform(upper - lower) + lower ,arc4random_uniform(upper - lower) + lower,arc4random_uniform(upper - lower) + lower]
           numbers.sort()
            serviceAndTips[service] = numbers.map({ (val) -> String! in
                String(val)+"%"
            })
        }
        
        for service in Store.services {
            serviceAndDescriptions[service] = "Typical \(service) around [ \((serviceAndTips[service]?[0] )!) - \((serviceAndTips[service]?[2])!) ] is the norm   pre - tax bill. Well !! game theory says tip , only if you prefer to come back. (You ll come back if you like it , and you ll tip) "
        }
        self.settingsTable.rowHeight = UITableViewAutomaticDimension;
        self.settingsTable.estimatedRowHeight = 44.0

    }

    override func viewDidAppear(_ animated: Bool) {
        Styles.styleNav(controller: self)
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if(indexPath.section == 1) {
            selectRow(cell:cell,indexPath:indexPath )
        }
    }
    
    
    func selectRow(cell:UITableViewCell , indexPath:IndexPath) {
        let indexes:[Int] = Store.services.enumerated().filter {
            $0.element.contains(Store.service)
            }.map{$0.offset}
        if(indexPath.row == indexes[0]) {
            cell.setSelected(true, animated: false)
            settingsTable.selectRow(at: indexPath, animated: true, scrollPosition: UITableViewScrollPosition.none)
        }
        
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
            return Store.sections[section]
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return Store.sections.count
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedService:String = Store.services[indexPath.item]
        
        if(indexPath.section == 1) {
            Store.storeDefaultServiceDetails(serviceArg: selectedService, serviceDetailArg: serviceAndDescriptions[selectedService]!, segmentTipArray: serviceAndTips[selectedService]!)
            
        }
            tipPercentChanged(fromtext: false)
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 44
    }
    
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        let header:UITableViewHeaderFooterView = view as! UITableViewHeaderFooterView
        header.textLabel?.font = UIFont(name: "Avenir Next", size: 18)
        header.textLabel?.textColor = UIColor.white
        view.tintColor = Styles.themeColor()
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.keyboardAppearance = UIKeyboardAppearance.alert
    }

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath)
        -> UITableViewCell {
            var cell = UITableViewCell(style: .default, reuseIdentifier: "cell");
            if(indexPath.section == 0 )
            {
                if(indexPath.row == 0) {
                    cell = tableView.dequeueReusableCell(withIdentifier: "settingscell") as! SettingsCell
                    cell.backgroundColor = UIColor.lightGray
                }
                if(indexPath.row == 1) {
                     cell = tableView.dequeueReusableCell(withIdentifier: "savecell") as! ShareCell
                }
                if(indexPath.row == 2 ){
                    cell = tableView.dequeueReusableCell(withIdentifier: "defaulttipcell") as! DefaultTipCell
                    let dCell:DefaultTipCell  = cell as! DefaultTipCell
                    defaultTipPercent = dCell.defaultTipPercent
                    dCell.defaultTipPercent.text! = String(Int(Store.defaultTip()))
                    dCell.defaultTipPercent.delegate = self
                    dCell.defaultTipPercent.addTarget(self, action: #selector(SettingsViewController.didTipPercentChange), for: UIControlEvents.editingChanged)

                }
              cell.selectionStyle = UITableViewCellSelectionStyle.none
              cell.accessoryType = UITableViewCellAccessoryType.none

            }else{
                cell.textLabel?.text = sectionData[indexPath.section]![indexPath.row]
            }
            cell.configureFlatCell(with: UIColor.white, selectedColor: UIColor.gray)
            cell.cornerRadius = 5.0;
            cell.separatorHeight = 1.0;
            cell.textLabel?.font = UIFont(name: "Avenir Next", size: 16)
            
            return cell
    }
    
    
    func didTipPercentChange() {
        
        tipPercentChanged(fromtext:true)
    }

    
    //After text value entry is done.
    func tipPercentChanged(fromtext: Bool) {
        if(!fromtext){
            view.endEditing(true)
        }
        var percentString : String = defaultTipPercent.text!
        if(percentString != "") {
            percentString = percentString.replacingOccurrences(of: ",", with: "")
            percentString = percentString.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
            let tipPercent:Float = Float(percentString)!
            Store.storeDefaultTipe(defaultTip: tipPercent)
        }
    }
    
    //Touch up anywhere in view
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
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
