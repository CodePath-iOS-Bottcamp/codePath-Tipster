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
    let themeToggle = UISwitch(frame: CGRect(x: 100, y: 100, width: 300, height: 300))
    let settingsList = ["Dark Theme", "About"]
    static let slider = Default(key: "slider")
    static let toggle = Default(key: "toggle")

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        tableView.delegate = self
        
        tableView.dataSource = self
        
        tipSlider.minimumValue = 10
        
        tipSlider.maximumValue = 20
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if SettingsViewController.slider.returnValue() != nil{
            
            tipSliderLabel.text = "\(SettingsViewController.slider.returnValue()!)%"
            tipSlider.setValue(SettingsViewController.slider.returnValue() as! Float, animated: true)
            setToggle(SettingsViewController.toggle.returnValue()! as! Bool)
            
        }else{
            SettingsViewController.slider.saveValue(tipSlider.minimumValue)
            
            setToggle(false)
        }
    }
    
    //set toggle val and enable/disable slider absed on val
    func setToggle(_ aBool: Bool){
        enableDefault.setOn(aBool, animated: true)
        tipSlider.isUserInteractionEnabled = aBool
        SettingsViewController.toggle.saveValue(aBool)
    }
    
    //update label text based on slider value when it changes
    @IBAction func changePercent(_ sender: Any) {
        tipSliderLabel.text = "\(Int(tipSlider.value))%"
        SettingsViewController.slider.saveValue(Int(tipSlider.value))
    }
    
    //disable/enable slider when toggle is flipped
    @IBAction func onToggle(_ sender: Any) {
        setToggle(enableDefault.isOn)
        //toggle.saveValue(enableDefault.isOn)
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "textCell0", for: indexPath)
        
        let row = indexPath.row
        
        switch row {
            case 0:
                cell.accessoryView = themeToggle    //manually add 
            case 1:
                cell.accessoryType = .disclosureIndicator
            default:
                break
        }
        
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
