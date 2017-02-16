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
    @IBOutlet var secondView: UIView!
    @IBOutlet var firstView: UIView!
    @IBOutlet var tipLabel: UILabel!
    @IBOutlet var totalLabel: UILabel!
    @IBOutlet var numPatronLabel: UILabel!
    @IBOutlet var tipControl: UISegmentedControl!
    let tipPercentage = [18, 20, 25]
    let numFormat = NumberFormatter()
    let defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        numFormat.groupingSeparator = ","
        numFormat.numberStyle = .currency
        numFormat.locale = Locale.current
        
        self.firstView.alpha = 0
        self.secondView.alpha = 0
        
        UIView.animate(withDuration: 1.2, animations: {
            self.firstView.alpha = 1
            self.secondView.alpha = 1
        })
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        billField.becomeFirstResponder()
        
//        checkAppLifeTime()
        
        if billField.text != ""{    //check if coming back from settings screen
            if defaults.bool(forKey: "toggle"){
                calcTotal(defaults.integer(forKey: "slider"))
            }else{
                calcTotal(tipPercentage[tipControl.selectedSegmentIndex])
            }
            
        }else if(defaults.object(forKey: "total") != nil){//see if a total value was previous saved
            if (defaults.double(forKey: "bill") == 0.0){ //check to see if app vals reset or not
                billField.text = ""
            }else{
                billField.text = String(defaults.double(forKey: "bill"))
            }
            
            //fill labels from NSDefault
            tipLabel.text = defaults.string(forKey: "tip")
            totalLabel.text = defaults.string(forKey: "total")
            tipControl.selectedSegmentIndex = defaults.integer(forKey: "segment")
            numPatronLabel.text = defaults.string(forKey: "numPatron")
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
        defaults.set(aBill, forKey: "bill")
        defaults.set(aTip, forKey: "tip")
        defaults.set(aTotal, forKey: "total")
        defaults.set(aNumPatron, forKey: "numPatron")
        defaults.set(tipControl.selectedSegmentIndex, forKey: "segment")
    }
    
    
    //determines whether to calculate tip with the default value or selected segment
    @IBAction func calculateTip(_ sender: AnyObject) {
        
        if defaults.bool(forKey: "toggle"){
            calcTotal(defaults.integer(forKey: "slider"))
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

