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
    var cell: UITableViewCell!
    @IBOutlet var header: UIView!
    @IBOutlet var percentageSection: UIView!
    @IBOutlet var tipSlider: UISlider!
    @IBOutlet var tipSliderLabel: UILabel!
    @IBOutlet var enableDefault: UISwitch!
    var themeSwitch: UISwitch!
    let defaults = UserDefaults.standard
    let darkBlue = UIColor(red: 10.0/255.0, green: 80.0/255.0, blue: 204.0/255.0, alpha: 1.0)
    let backgroundBlue = UIColor(red: 32.0/255.0, green: 101.0/255.0, blue: 249.0/255.0, alpha: 1.0)

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        tableView.delegate = self
        
        tableView.dataSource = self
        
        tipSlider.minimumValue = 10
        
        tipSlider.maximumValue = 20
        
        cell = tableView.dequeueReusableCell(withIdentifier: "textCell0")
        
        themeSwitch = UISwitch(frame: CGRect(x: 100, y: 100, width: 300, height: 300))
        
        themeSwitch.addTarget(self, action: #selector(self.enableDarkTheme), for: .valueChanged)

        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if defaults.object(forKey: "slider") != nil{
            
            tipSliderLabel.text = "\(defaults.integer(forKey: "slider"))%"
            tipSlider.setValue(defaults.float(forKey: "slider"), animated: true)
            
            enableSlider(defaults.bool(forKey: "toggle"))
            
            themeSwitch.setOn(defaults.bool(forKey: "isDark"), animated: true)
            enableDarkTheme()
            
        }else{
            
            changePercent((val: Int(tipSlider.minimumValue)))
            
            enableSlider(false)
            
            defaults.set(themeSwitch.isOn, forKey: "isDark")
            
        }
    }
    
    //enable dark theme
    func enableDarkTheme(){
        if themeSwitch.isOn{
            self.header.backgroundColor = UIColor.gray
            self.percentageSection.backgroundColor = UIColor.black
            self.tableView.backgroundColor = UIColor.black
            self.cell.backgroundColor = UIColor.gray
        }else{
            self.header.backgroundColor = darkBlue
            self.percentageSection.backgroundColor = backgroundBlue
            self.tableView.backgroundColor = backgroundBlue
            self.cell.backgroundColor = darkBlue
        }
        
        defaults.set(themeSwitch.isOn, forKey: "isDark")
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
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        cell.accessoryView = themeSwitch
        cell.selectionStyle = .none
        
        cell.textLabel?.text = "Dark Theme"
        
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
