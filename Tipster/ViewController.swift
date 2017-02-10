//
//  ViewController.swift
//  Tipster
//
//  Created by Arthur Burgin on 1/28/17.
//  Copyright © 2017 Arthur Burgin. All rights reserved.
//

import UIKit

class TCViewController: UIViewController {

    @IBOutlet var billField: UITextField!
    @IBOutlet var tipLabel: UILabel!
    @IBOutlet var totalLabel: UILabel!
    @IBOutlet var tipControl: UISegmentedControl!
    let defaults = UserDefaults.standard
    let tipPercentage = [18, 20, 25]
    let numFormat = NumberFormatter()
    var savedTip:Int!
    var minutes:Int!
    var rawTime:Int!
    var bill:Double!
    var tip:Double!
    var total:Double!
    var startTime = Date()
    var currTime = NSDate()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        billField.becomeFirstResponder()
        
        checkAppLifeTime()
        
        if billField.text != ""{
            if defaults.bool(forKey: "toggleValue"){
                calcTotal(val: defaults.integer(forKey: "sliderValue"))
            }else{
                calcTotal(val: tipPercentage[tipControl.selectedSegmentIndex])
            }
        }else if((defaults.object(forKey: "totalVal")) != nil){
            if (defaults.double(forKey: "billVal") == 0.0){
                billField.text = ""
            }else{
                billField.text = String(defaults.double(forKey: "billVal"))
            }
            tipLabel.text = defaults.string(forKey: "tipVal")
            totalLabel.text = defaults.string(forKey: "totalVal")
            tipControl.selectedSegmentIndex = defaults.integer(forKey: "segmentVal")
        }
        
    }
    
    //calculates the total based on bill and tip amounts
    func calcTotal(val: Int){
        bill = Double(billField.text!) ?? 0
        tip = bill * Double(val)/100
        total = bill + tip
        
        numFormat.groupingSeparator = ","
        numFormat.numberStyle = .currency
        numFormat.locale = Locale.current
        
        tipLabel.text = numFormat.string(from: tip as NSNumber)!
        totalLabel.text = numFormat.string(from: total as NSNumber)!

        saveVals(bill: bill, tip: tipLabel.text!, total: totalLabel.text!)
    }
    
    //persists values from each field
    func saveVals(bill: Double, tip: String, total: String){
        defaults.set(bill, forKey: "billVal")
        defaults.set(tip, forKey: "tipVal")
        defaults.set(total, forKey: "totalVal")
        defaults.set(tipControl.selectedSegmentIndex, forKey: "segmentVal")
    }
    
    //perform a time check to see if app was last used in 10 minutes
    func checkAppLifeTime(){
        if(defaults.object(forKey: "startTime") != nil){
            rawTime = Int(currTime.timeIntervalSince(defaults.object(forKey: "startTime") as! Date))
            minutes = (rawTime/60)
            
            if minutes >= 10{
                defaults.setValue(startTime, forKey: "startTime")
                resetBill()
            }
        }else{
            defaults.setValue(startTime, forKey: "startTime")
        }
    }
    
    //reset all values except default tip percentage
    func resetBill(){
        bill = 0.0
        tip = 0.0
        total = 0.0
        defaults.set(bill, forKey: "billVal")
        defaults.set(bill, forKey: "tipVal")
        defaults.set(bill, forKey: "totalVal")
        defaults.set(false, forKey: "toggleValue")
        calcTotal(val: 0)
    }
    
    //calculates tip using the segment control changes
    @IBAction func changeTip(_ sender: Any) {
        calculateTip(sender)    //use calculateTip until it can be used for two events
    }
    
    //determines whether to calculate tip with the default value or selected segment
    @IBAction func calculateTip(_ sender: Any) {
        
        if defaults.bool(forKey: "toggleValue"){
            calcTotal(val: defaults.integer(forKey: "sliderValue"))
        }else{
            calcTotal(val: tipPercentage[tipControl.selectedSegmentIndex])
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

