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
    
    let settingsList = ["Theme", "About"]
    
    let textCellID = "textCell"
    
    @IBOutlet var enableDefault: UISwitch!
    
    let defaults = UserDefaults.standard

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        tableView.delegate = self
        
        tableView.dataSource = self
        
        tipSlider.minimumValue = 10
        
        tipSlider.maximumValue = 20
        
        if defaults.object(forKey: "sliderValue") != nil{
            
            tipSliderLabel.text = String(defaults.integer(forKey: "sliderValue"))+"%"
            tipSlider.setValue(Float(defaults.integer(forKey: "sliderValue")), animated: true)
            
            enableDefault.setOn(defaults.bool(forKey: "toggleValue"), animated: true)
            
            if !enableDefault.isOn{
                tipSlider.isUserInteractionEnabled = false
            }else{
                tipSlider.isUserInteractionEnabled = true
            }
            
        }else{
            
            tipSliderLabel.text = String(Int(tipSlider.minimumValue))+"%"
            tipSlider.setValue(Float(tipSlider.minimumValue), animated: true)
            
            enableDefault.setOn(false, animated: true)
            tipSlider.isUserInteractionEnabled = false
            
        }
        
    }
    
    @IBAction func changePercent(_ sender: Any) {
        tipSliderLabel.text = "\(Int(tipSlider.value))%"
    }
    
    @IBAction func saveValue(_ sender: Any) {
        defaults.set(Int(tipSlider.value), forKey: "sliderValue")
        defaults.synchronize()
    }
    
    @IBAction func onToggle(_ sender: Any) {
        if !enableDefault.isOn{
            tipSlider.isUserInteractionEnabled = false
        }else{
            tipSlider.isUserInteractionEnabled = true
        }
        defaults.set(enableDefault.isOn, forKey: "toggleValue")
        defaults.synchronize()
    }
    
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
