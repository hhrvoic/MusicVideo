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
    }
    func preferedFontChange(){
        lblAboutDisplay.font = UIFont.preferredFontForTextStyle(UIFontTextStyleSubheadline)
        lblApiCount.font = UIFont.preferredFontForTextStyle(UIFontTextStyleSubheadline)
        lblFeedbackDisplay.font = UIFont.preferredFontForTextStyle(UIFontTextStyleSubheadline)
        lblImageDisplay.font = UIFont.preferredFontForTextStyle(UIFontTextStyleSubheadline)
        lblSecurityDisplay.font = UIFont.preferredFontForTextStyle(UIFontTextStyleSubheadline)

        
    }
    
   
}
