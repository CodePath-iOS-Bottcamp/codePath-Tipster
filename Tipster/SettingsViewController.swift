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
    var themeSwitch: UISwitch!
    var isDark: Bool!
    let settingsList = ["Dark Theme", "About"]
    let defaults = UserDefaults.standard

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        tableView.delegate = self
        
        tableView.dataSource = self
        
        tipSlider.minimumValue = 10
        
        tipSlider.maximumValue = 20
        
        isDark = false
        
        themeSwitch = UISwitch(frame: CGRect(x: 100, y: 100, width: 300, height: 300))
        
        themeSwitch.addTarget(self, action: #selector(self.enableDarkTheme), for: .valueChanged)
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if defaults.object(forKey: "slider") != nil{   //if object exists
            
            tipSliderLabel.text = "\(defaults.integer(forKey: "slider"))%"
            tipSlider.setValue(defaults.float(forKey: "slider"), animated: true)
            
            enableSlider(defaults.bool(forKey: "toggle"))
            
        }else{  //else init label, disable slider and set toggle to false
            
            changePercent((val: Int(tipSlider.minimumValue)))
            
            enableSlider(false)
            
        }
    }
    
    //enable dark theme
    func enableDarkTheme(){
    
    }

    //disable/enable slider when toggle is flipped
    func enableSlider(_ aBool: Bool){
        enableDefault.setOn(aBool, animated: true)
        tipSlider.isUserInteractionEnabled = aBool
        defaults.set(aBool, forKey: "toggle")
    }
    
    //update label text based on slider value when it changes
    @IBAction func changePercent(_ sender: Any) {
        tipSliderLabel.text = "\(Int(tipSlider.value))%"
        defaults.set(Int(tipSlider.value), forKey: "slider")
        
    }
    
    //disable/enable slider when toggle is flipped
    @IBAction func onToggle(_ sender: Any) {
        enableSlider(enableDefault.isOn)
    }
    
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
                cell.accessoryView = themeSwitch
                cell.selectionStyle = .none
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
