//
//  SettingsTVC.swift
//  MusicVideo
//
//  Created by FOI on 25/05/16.
//  Copyright © 2016 hrvoje. All rights reserved.
//

import UIKit

class SettingsTVC: UITableViewController {
    @IBOutlet weak var lblAboutDisplay: UILabel!
    @IBOutlet weak var lblFeedbackDisplay: UILabel!
    
    @IBOutlet weak var lblSecurityDisplay: UILabel!
    @IBOutlet weak var swTouchId: UISwitch!
    @IBOutlet weak var lblImageDisplay: UILabel!
    @IBOutlet weak var swImageQuality: UISwitch!
    @IBOutlet weak var lblApiCount: UILabel!
    @IBOutlet weak var slidApiCount: UISlider!
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.alwaysBounceVertical = false
        // Do any additional setup after loading the view.
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "preferedFontChange", name: UIContentSizeCategoryDidChangeNotification, object: nil)
        title = "Settings" 
        swTouchId.on=NSUserDefaults.standardUserDefaults().boolForKey("SecSetting")
        swImageQuality.on = NSUserDefaults.standardUserDefaults().boolForKey("ImgSetting")
        if NSUserDefaults().integerForKey("NumberOfVidsSetting") == 0
        {
            slidApiCount.value = 10.0
        }else {
            slidApiCount.value = Float(NSUserDefaults().integerForKey("NumberOfVidsSetting"))
        }
        lblApiCount.text = String(Int(slidApiCount.value))
    }
    @IBAction func numberOfVidSettChanged(sender: UISlider) {
        let numberOfVids:Int = Int(slidApiCount.value)
        lblApiCount.text = String (numberOfVids)
        let defaults = NSUserDefaults.standardUserDefaults()
        defaults.setInteger(numberOfVids, forKey: "NumberOfVidsSetting")
    }
    @IBAction func touchIdSecurityChanged(sender: UISwitch) {
        let defaults = NSUserDefaults.standardUserDefaults()
        defaults.setBool(swTouchId.on, forKey: "SecSetting")
        
       
    }
    @IBAction func imageSettingChanged(sender: UISwitch) {
        let defaults = NSUserDefaults.standardUserDefaults()
        defaults.setBool(swImageQuality.on, forKey: "ImgSetting")
    }
    func preferedFontChange(){
        lblAboutDisplay.font = UIFont.preferredFontForTextStyle(UIFontTextStyleSubheadline)
        lblApiCount.font = UIFont.preferredFontForTextStyle(UIFontTextStyleSubheadline)
        lblFeedbackDisplay.font = UIFont.preferredFontForTextStyle(UIFontTextStyleSubheadline)
        lblImageDisplay.font = UIFont.preferredFontForTextStyle(UIFontTextStyleSubheadline)
        lblSecurityDisplay.font = UIFont.preferredFontForTextStyle(UIFontTextStyleSubheadline)
        
        
    }
    
   
}
