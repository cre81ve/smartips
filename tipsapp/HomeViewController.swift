//
//  ViewController.swift
//  tipsapp
//
//  Created by CK on 3/1/17.
//  Copyright © 2017 CK. All rights reserved.
//

import UIKit
import FlatUIKit

extension Float {
    func format(f: String) -> String {
        return String(format: "%\(f)%.2f", self)
    }
}

class HomeViewController: UIViewController,UITextFieldDelegate,UIGestureRecognizerDelegate {

    
    @IBOutlet weak var totalAmount: UILabel!
    @IBOutlet weak var service: UILabel!
    @IBOutlet weak var segmentControl: FUISegmentedControl!
    @IBOutlet weak var tipLabel: UILabel!
    @IBOutlet weak var billLabel: UILabel!
    @IBOutlet weak var personSlider: UISlider!
    @IBOutlet weak var tipAmount: UILabel!
    @IBOutlet weak var billAmount: FUITextField!
    @IBOutlet weak var serviceDetail: UILabel!
    
    var bill:Float = 0
    var tip:Float = 0
    var total:Float = 0
    var currencySymbol:String = "$"
    var currencyCode:String = "USD"
    var tipPercent: Float = 15.0
    var sharedBy:Int = 1
    
    let formatter = NumberFormatter()
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        //styles
        reStyle()
        let (storedBill,timeStored) = Store.billAmount();
        let currentTime:Int = Int(floor(Date().timeIntervalSince1970))
        if(timeStored != 0 && (currentTime - timeStored < 10*60*1000)) {
            bill = storedBill
        }
        
        billAmount.delegate = self
        billAmount.addTarget(self, action: #selector(HomeViewController.didBillValueChange), for: UIControlEvents.editingChanged)
        billAmount.text = formatter.string(from: NSNumber(value:bill))
        
        //slider
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(HomeViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
        currencyCode = NSLocale.current.currencyCode! as String
        currencySymbol = NSLocale.current.currencySymbol! as String
        billAmount.placeholder = currencySymbol + String(format:"%.2f", bill)
        
        service.backgroundColor = UIColor.clear
        serviceDetail.backgroundColor = UIColor.clear

        //formatter
        formatter.numberStyle = .currency
        billAmount.becomeFirstResponder()
        recalculateTip(fromTextField: false)
        
    }
    
    
    
    override func viewDidAppear(_ animated: Bool) {

        var tipPercentVar:String =  Store.segmentTip[1]
        tipPercentVar =  tipPercentVar.substring(to: tipPercentVar.index(before: tipPercentVar.endIndex))
        if(Store.service == "Waiters") {
            tipPercent = Store.defaultTip()
            tipPercentVar = "\(Int(tipPercent))"
        }else{
            tipPercent = Float(tipPercentVar)!
        }
        
        Store.segmentTip[1] = "\(tipPercentVar)%"

        segmentControl.removeAllSegments()
        segmentControl.insertSegment(withTitle: Store.segmentTip[0], at: 0, animated: true)
        segmentControl.insertSegment(withTitle: Store.segmentTip[1], at: 1, animated: true)
        segmentControl.insertSegment(withTitle: Store.segmentTip[2], at: 2, animated: true)
        segmentControl.selectedSegmentIndex = 1
        
        service.text = Store.service
        serviceDetail.text = Store.serviceDetail

        self.service.alpha = 0.7
        UIView.animate(withDuration: 1.0, delay: 0.3, options: UIViewAnimationOptions.curveEaseOut, animations: {
            self.service.backgroundColor = Styles.themeColor()
            self.serviceDetail.backgroundColor = Styles.themeColor()
            self.service.alpha = 1.0
        })
        self.serviceDetail.backgroundColor = Styles.themeColor()

        recalculateTip(fromTextField: false)
        Styles.styleNav(controller: self)
        self.billAmount.alpha = 0.7;
        self.billAmount.borderStyle = UITextBorderStyle.roundedRect
        
        self.billAmount.borderColor = Styles.themeColor()
        self.billAmount.borderWidth = 3.0
//        let optionsFrame:CGRect = self.billAmount.frame;
        
        UIView.animate(withDuration: 2.0, delay: 0.3, options: UIViewAnimationOptions.curveEaseOut, animations: {
            self.billAmount.alpha=1;
            self.billAmount.layer.borderWidth = 1
            self.billAmount.layer.borderColor = Styles.themeColor().cgColor
        })
        reStyle()
    }
    
    func reStyle() {
        Styles.styleSlider(slider: personSlider)
        Styles.styleText(tf: billAmount);
        Styles.styleSegmentControl(segmentControl: segmentControl)
        Styles.styleLabels(label: tipLabel)
        Styles.styleLabels(label: billLabel)
        Styles.styleLabels(label: tipAmount)

    }
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.keyboardAppearance = UIKeyboardAppearance.alert
    }
    
    //change billInteger only if - text changes.
    func didBillValueChange() {
        var billString : String = billAmount.text!
        billString = billString.replacingOccurrences(of: ",", with: "")
        billString.remove(at: billString.startIndex)
        billString = billString.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        if(billString.isEmpty){
            bill = 0
        }
        else {
            bill = Float(billString)!
        }
        recalculateTip(fromTextField: true)
        Store.storeBillAmount(amount: bill)
    }

    //After text value entry is done.
    func dismissKeyboard() {
        view.endEditing(true)
        recalculateTip(fromTextField: false)

    }
    
    //Touch up anywhere in view
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        recalculateTip(fromTextField: false)
        return true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    //Shared By:
    @IBAction func sliderValueChanged(_ sender: Any) {
        let newval:Int = Int(personSlider.value)
        personSlider.value = Float(newval)
        if(newval >= 1 && newval <= 10) {
            sharedBy = newval
        }
        recalculateTip(fromTextField: false)
    }
    
    //Tip Percent:
    @IBAction func tipPercentChanged(_ sender: FUISegmentedControl) {
        var title:String = sender.titleForSegment(at: segmentControl.selectedSegmentIndex)!
        title = title.substring(to: title.index(before: title.endIndex))
        tipPercent = Float(title)!
        recalculateTip(fromTextField: false)
    }
    
    
    func recalculateTip(fromTextField: Bool) {
        //change Labels 
        billLabel.text = "Bill (\(sharedBy))"
        tipLabel.text = "Tip (\(sharedBy))"
        tip = (bill/100.00)*tipPercent
   
        //change Bill & Tip
        let billToShow:Float = bill/Float(sharedBy)
        if(!fromTextField) {
            billAmount.text = formatter.string(from: NSNumber(value:billToShow))
        }
        let tipToShow:Float = tip/Float(sharedBy)
        tipAmount.text = formatter.string(from: NSNumber(value:tipToShow))
        totalAmount.text = formatter.string(from: NSNumber(value: billToShow+tipToShow))
    }

}

