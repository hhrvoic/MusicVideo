//
//  SettingsTVC.swift
//  MusicVideo
//
//  Created by FOI on 25/05/16.
//  Copyright © 2016 hrvoje. All rights reserved.
//

import UIKit
import MessageUI
class SettingsTVC: UITableViewController, MFMailComposeViewControllerDelegate{
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
    @IBOutlet weak var numVideos: UILabel!
    @IBOutlet weak var dragTheSlider: UILabel!
    @IBAction func imageSettingChanged(sender: UISwitch) {
        let defaults = NSUserDefaults.standardUserDefaults().setBool(swImageQuality.on, forKey: "ImgSetting")
    }
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) { //presenting mail view controller - todo: test it on real device
        
        if indexPath.section == 0 && indexPath.row == 1 {
            
            let mailComposeViewController = configureMail()
            
            if MFMailComposeViewController.canSendMail() {
                self.presentViewController(mailComposeViewController,  animated: true, completion: nil)
            }
            else
            {
                // No email account Setup on Phone
                mailAlert()
            }
            tableView.deselectRowAtIndexPath(indexPath, animated: true)
        }
        
        
        
    }
    
    func configureMail() -> MFMailComposeViewController {
        
        let mailComposeVC = MFMailComposeViewController()
        mailComposeVC.mailComposeDelegate = self
        mailComposeVC.setToRecipients(["hhrvoic@foi.hr"])
        mailComposeVC.setSubject("Music Video App Feedback")
        mailComposeVC.setMessageBody("Hi Hrvoje,\n\nI would like to share the following feedback...\n", isHTML: false)
        return mailComposeVC
    }
    
    
    func mailAlert() {
        
        let alertController: UIAlertController = UIAlertController(title: "Alert", message: "No e-Mail Account setup for Phone", preferredStyle: .Alert)
        
        let okAction = UIAlertAction(title: "Ok", style: .Default) { action -> Void in
            //do something if you want
        }
        
        alertController.addAction(okAction)
        
        self.presentViewController(alertController, animated: true, completion: nil)
        
    }
    
    
    
    func mailComposeController(controller: MFMailComposeViewController, didFinishWithResult result: MFMailComposeResult, error: NSError?) {
        
        
        switch result.rawValue {
        case MFMailComposeResultCancelled.rawValue:
            print("Mail cancelled")
        case MFMailComposeResultSaved.rawValue:
            print("Mail saved")
        case MFMailComposeResultSent.rawValue:
            print("Mail sent")
        case MFMailComposeResultFailed.rawValue:
            print("Mail Failed")
        default:
            print("Unknown Issue")
        }
        self.dismissViewControllerAnimated(true, completion: nil)}
    
    
    
    
    
    func preferedFontChange(){
        lblAboutDisplay.font = UIFont.preferredFontForTextStyle(UIFontTextStyleSubheadline)
        lblApiCount.font = UIFont.preferredFontForTextStyle(UIFontTextStyleSubheadline)
        lblFeedbackDisplay.font = UIFont.preferredFontForTextStyle(UIFontTextStyleSubheadline)
        lblImageDisplay.font = UIFont.preferredFontForTextStyle(UIFontTextStyleSubheadline)
        lblSecurityDisplay.font = UIFont.preferredFontForTextStyle(UIFontTextStyleSubheadline)
        numVideos.font = UIFont.preferredFontForTextStyle(UIFontTextStyleSubheadline)
        dragTheSlider.font = UIFont.preferredFontForTextStyle(UIFontTextStyleFootnote)
        
    }
    
    
   
}
