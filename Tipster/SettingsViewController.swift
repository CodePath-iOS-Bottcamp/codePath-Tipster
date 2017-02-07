//
//  SettingsViewController.swift
//  Tipster
//
//  Created by Arthur Burgin on 1/28/17.
//  Copyright © 2017 Arthur Burgin. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController, UITableViewDataSource,UITableViewDelegate {
    
    @IBOutlet var tableView: UITableView!
    @IBOutlet var tipSlider: UISlider!
    @IBOutlet var tipSliderLabel: UILabel!
    @IBOutlet var enableDefault: UISwitch!
    let settingsList = ["Theme", "About"]
    let textCellID = "textCell"
    let defaults = UserDefaults.standard

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        tableView.delegate = self
        
        tableView.dataSource = self
        
        tipSlider.minimumValue = 10
        
        tipSlider.maximumValue = 20
        
        if defaults.object(forKey: "sliderValue") != nil{   //if object exists
            
            setSliderVal(val: defaults.integer(forKey: "sliderValue"))
            
            setToggle(aBool: defaults.bool(forKey: "toggleValue"))
            
        }else{  //else init label, disable slider and set toggle to false
            
            setSliderVal(val: Int(tipSlider.minimumValue))
            
            setToggle(aBool: false)
            
        }
        
    }
    
    //set the label text and value of the slider
    func setSliderVal(val: Int){
        tipSliderLabel.text = String(val)+"%"
        tipSlider.setValue(Float(val), animated: true)
    }
    
    //set toggle val and enable/disable slider absed on val
    func setToggle(aBool: Bool){
        enableDefault.setOn(aBool, animated: true)
        
        if !aBool{
            tipSlider.isUserInteractionEnabled = false
        }else{
            tipSlider.isUserInteractionEnabled = true
        }
    }
    
    //update label text based on slider value when it changes
    @IBAction func changePercent(_ sender: Any) {
        tipSliderLabel.text = "\(Int(tipSlider.value))%"
        defaults.set(Int(tipSlider.value), forKey: "sliderValue")
        defaults.synchronize()
    }
    
    //disable/enable slider when toggle is flipped
    @IBAction func onToggle(_ sender: Any) {
        setToggle(aBool: enableDefault.isOn)
        defaults.set(enableDefault.isOn, forKey: "toggleValue")
        defaults.synchronize()
    }
    
    //save the value when slider stops moving w/ touchupinside TESTING
    //    @IBAction func saveValue(_ sender: Any) {
    //        defaults.set(Int(tipSlider.value), forKey: "sliderValue")
    //        defaults.synchronize()
    //    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return settingsList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: textCellID, for: indexPath)
        
        let row = indexPath.row
        
        cell.textLabel?.text = settingsList[row]
        
        return cell
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
