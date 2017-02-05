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
    var savedTip = 0
    var bill = 0.0
    var tip = 0.0
    var total = 0.0
    
    /////////////////////persistt field, tip and total/////////////////////////////////////////////////////////
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        print("view did load")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if defaults.bool(forKey: "toggleValue"){
            if billField.text != ""{
                savedTip = defaults.integer(forKey: "sliderValue")
                
                bill = Double(billField.text!) ?? 0
                tip = bill * Double(savedTip)/100
                total = bill + tip
                
                tipLabel.text = String(format: "$%.2f", tip)
                totalLabel.text = String(format: "$%.2f", total)
            }
        }else{
            if billField.text != ""{
                let tipPercentage = [0.18, 0.20, 0.25]
                
                bill = Double(billField.text!) ?? 0
                tip = bill * tipPercentage[tipControl.selectedSegmentIndex]
                total = bill + tip
                
                tipLabel.text = String(format: "$%.2f", tip)
                totalLabel.text = String(format: "$%.2f", total)
            }
        }
        //if theres a value in the text field and theres a saved value then set the tip
        print("view will appear")
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print("view did appear")
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        print("view will disappear")
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print("view will disappear")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    //could'nt make a "value changed" connection(ctrl+drag) between UI elemtn and calculateTip function so this function was created
    @IBAction func changeTip(_ sender: Any) {
        calculateTip(sender)
    }
    
    @IBAction func calculateTip(_ sender: Any) {
        
        let tipPercentage = [0.18, 0.20, 0.25]
        
        bill = Double(billField.text!) ?? 0
        
        if defaults.bool(forKey: "toggleValue"){
            tip = bill * Double(defaults.integer(forKey: "sliderValue"))/100
        }else{
            tip = bill * tipPercentage[tipControl.selectedSegmentIndex]
        }
        
        total = bill + tip
        
        tipLabel.text = String(format: "$%.2f", tip)
        totalLabel.text = String(format: "$%.2f", total)
        
    }
    
    @IBAction func onTap(_ sender: Any) {
        print(defaults.integer(forKey: "sliderValue"))
        view.endEditing(true)
    }


}

