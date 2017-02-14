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
    @IBOutlet var numPatronLabel: UILabel!
    @IBOutlet var tipControl: UISegmentedControl!
    let tipPercentage = [18, 20, 25]
    let numFormat = NumberFormatter()
    let slider = SettingsViewController.slider
    let toggle = SettingsViewController.toggle
    let bill = Default(key: "bill")
    let tip = Default(key: "tip")
    let total = Default(key: "total")
    let segment = Default(key: "segment")
    let numPatron = Default(key: "numPatron")
    let startTime = Default(key: "startTime")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        numFormat.groupingSeparator = ","
        numFormat.numberStyle = .currency
        numFormat.locale = Locale.current
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        billField.becomeFirstResponder()
        
        checkAppLifeTime()
        
        if billField.text != ""{    //check if coming back from settings screen
            if toggle.returnValue() as! Bool{
                calcTotal(slider.returnValue() as! Int)
            }else{
                calcTotal(tipPercentage[tipControl.selectedSegmentIndex])
            }
        }else if(total.returnValue() != nil){//see if a total value was previous saved
            if (bill.returnValue() as! Double == 0.0){ //check to see if app vals reset or not
                billField.text = ""
            }else{
                billField.text = "\(bill.returnValue()!)"
            }
            //fill labels from NSDefault
            tipLabel.text = "\(tip.returnValue()!)"
            totalLabel.text = "\(total.returnValue()!)"
            tipControl.selectedSegmentIndex = segment.returnValue() as! Int
            numPatronLabel.text = "\(numPatron.returnValue()!)"
        }
        
        
    }
    
    //calculates the total based on bill and tip amounts
    func calcTotal(_ val: Int){
        var myBill:Double!
        var myTip:Double!
        var myTotal:Double!
        var myNumPatron:Double!
        
        myNumPatron = Double(numPatronLabel.text!)
        myBill = Double(billField.text!) ?? 0
        myTip = (myBill * (Double(val)/100))/myNumPatron
        myTotal = myBill/myNumPatron + myTip
        
        tipLabel.text = numFormat.string(from: myTip as NSNumber)!
        totalLabel.text = numFormat.string(from: myTotal as NSNumber)!

        saveVals(myBill, tipLabel.text!, totalLabel.text!, Int(myNumPatron))
    }
    
    //persists values from each field
    func saveVals(_ aBill: Double, _ aTip: String, _ aTotal: String, _ aNumPatron: Int){
        
        self.bill.saveValue(aBill)
        self.tip.saveValue(aTip)
        self.total.saveValue(aTotal)
        self.segment.saveValue(tipControl.selectedSegmentIndex)
        self.numPatron.saveValue(aNumPatron)
    }
    
    //perform a time check to see if app was last used in 10 minutes
    func checkAppLifeTime(){
        let startTime = Date()
        let currTime = NSDate()
        var minutes:Int!
        var rawTime:Int!
        
        if(self.startTime.returnValue() != nil){
            rawTime = Int(currTime.timeIntervalSince(self.startTime.returnValue() as! Date))
            minutes = (rawTime/60)
            
            if minutes >= 10{
                self.startTime.saveValue(startTime)
                resetBill()
            }
        }else{
            self.startTime.saveValue(startTime)
        }
    }
    
    //reset all values except default tip percentage
    func resetBill(){
        toggle.saveValue(false)
        saveVals(0.0, "0.0", "0.0", 1)
        calcTotal(0)
    }
    
    
    //determines whether to calculate tip with the default value or selected segment
    @IBAction func calculateTip(_ sender: AnyObject) {
        
        if toggle.returnValue() as! Bool{
            calcTotal(slider.returnValue() as! Int)
        }else{
            calcTotal(tipPercentage[tipControl.selectedSegmentIndex])
        }
        
    }
    
    //subtracts num of patrons to divide by
    @IBAction func subtractPatron(_ sender: Any) {
        var numPatron = Int(numPatronLabel.text!)
        if numPatron! > 1{
            numPatron = numPatron! - 1
            numPatronLabel.text = "\(numPatron!)"
        }
        calculateTip(sender as AnyObject)
        
    }
    
    //adds num of patrons to divide by
    @IBAction func addPatron(_ sender: Any) {
        var numPatronVal = Int(numPatronLabel.text!)
        numPatronVal = numPatronVal! + 1
        numPatronLabel.text = "\(numPatronVal!)"
        calculateTip(sender as AnyObject)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

