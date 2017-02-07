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
    var savedTip = 0
    var bill = 0.0
    var tip = 0.0
    var total = 0.0
    
    /////////////////////persist field, tip and total/////////////////////////////////////////////////////////
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        print("view did load")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if billField.text != ""{
            if defaults.bool(forKey: "toggleValue"){
                calcTotal(val: defaults.integer(forKey: "sliderValue"))
            }else{
                calcTotal(val: tipPercentage[tipControl.selectedSegmentIndex])
            }
        }
        //if theres a value in the text field and theres a saved value then set the tip
        print("view will appear")
        
    }
    
    //calculates the total based on bill and tip amounts
    func calcTotal(val: Int){
        bill = Double(billField.text!) ?? 0
        tip = bill * Double(val)/100
        total = bill + tip
        
        tipLabel.text = String(format: "$%.2f", tip)
        totalLabel.text = String(format: "$%.2f", total)
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
    
    //touch anywhere on screen will make keyboard go away
    @IBAction func onTap(_ sender: Any) {
        view.endEditing(true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

