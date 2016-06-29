//
//  MusicVideoDetailVC.swift
//  MusicVideo
//
//  Created by FOI on 14/05/16.
//  Copyright © 2016 hrvoje. All rights reserved.
//

import UIKit
import AVKit
import AVFoundation
import LocalAuthentication

class MusicVideoDetailVC: UIViewController {

    @IBOutlet weak var vImageView: UIImageView!
    @IBOutlet weak var vNameLabel: UILabel!
    @IBOutlet weak var vGenreLabel: UILabel!
    @IBOutlet weak var vCostLabel: UILabel!
    @IBOutlet weak var vRightsLabel: UILabel!
    
    var video : MusicVideo!
    var securitySwitch:Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title  = video.vArtist
        vNameLabel.text = video.vName
        vCostLabel.text = video.vPrice
        vGenreLabel.text = video.vGenre
        vRightsLabel.text = video.vRights
        if let data = video.vImageData {
            vImageView.image = UIImage(data: data)
        }
        else {
            vImageView.image = UIImage(named: "imageNotAvailable")
        }
        // Do any additional setup after loading the view.
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "preferedFontChange", name: UIContentSizeCategoryDidChangeNotification, object: nil)
    }
    @IBAction func socialMedia(sender: UIBarButtonItem) {
        securitySwitch = NSUserDefaults.standardUserDefaults().boolForKey("SecSetting")
        if securitySwitch == true {
            touchIdCheck()
        }
        else {
            shareMedia()
        }
    }
    func shareMedia () {
        let activities: [String] = [
            "Have you had the opportunity to see this video?",
            ("\(video.vName) by \(video.vArtist)"),
            "Watch it and tell me what you think?",
             video.vLinkToiTunes,
            "Shared with the Music Video App" ]
            
      let activityVC: UIActivityViewController  = UIActivityViewController(activityItems: activities , applicationActivities:nil)
        activityVC.completionWithItemsHandler = {
            (activity, success, items, error) in
            if(activity == UIActivityTypeMail) {
                print("email selected")
            }
        }
        self.presentViewController(activityVC, animated: true, completion: nil)
        
    }
    func preferedFontChange(){
        
        vNameLabel.font=UIFont.preferredFontForTextStyle(UIFontTextStyleHeadline)
         vCostLabel.font=UIFont.preferredFontForTextStyle(UIFontTextStyleHeadline)
         vGenreLabel.font=UIFont.preferredFontForTextStyle(UIFontTextStyleHeadline)
         vRightsLabel.font=UIFont.preferredFontForTextStyle(UIFontTextStyleHeadline)
    }

 
    @IBAction func playVideo(sender: UIBarButtonItem) {
        let url = NSURL(string: video.vVideoUrl)
        let player = AVPlayer(URL: url!)
        let playerVC = AVPlayerViewController()
        playerVC.player=player
        self.presentViewController(playerVC, animated: true) {
            playerVC.player?.play()
        }
    }
    
    func touchIdCheck(){
        let alert = UIAlertController(title: "", message: "", preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "continue", style: .Cancel, handler: nil))
        
        let context = LAContext()
        var touchIDErr: NSError?
        let reason = "TouchID auth is needed to share info on Social Media"
        //if
        //if LAuth can be accessed (
        if context.canEvaluatePolicy(LAPolicy.DeviceOwnerAuthenticationWithBiometrics, error: &touchIDErr){
            context.evaluatePolicy(LAPolicy.DeviceOwnerAuthenticationWithBiometrics, localizedReason: reason, reply: { (success, policyError) -> Void in //closure runs in background thread (private, controlled by fw)
                if success { //auth success
                    dispatch_async(dispatch_get_main_queue()) { //get back to the main thread
                        //closure has refference to self (in another object)
                        //strong refference cycle happens - self has a pointer to the closure , closure has the pointer to the "self"
                            //unowned self - if self will never be nil (playing it safe) - unowned reference is always defined as a nonoptional type
                            //weak self - if self may be nil
                        [unowned self] in self.shareMedia()
                    }
                }
                else {
                    alert.title = "Unsuccesfull!"
                    switch LAError(rawValue: policyError!.code)! {
                    case .AppCancel:
                        alert.message="Authentication cancelled by application"
                    case .AuthenticationFailed:
                        alert.message="Authentication failed - user failed to provide valid credentials"
                    case .PasscodeNotSet:
                        alert.message="Passcode not set on the device"
                    case .SystemCancel:
                        alert.message = "Authetication cancelled by the system"
                    case .TouchIDLockout:
                        alert.message = "Too many failed attempts."
                    case .UserCancel:
                        alert.message="Authentication cancelled by the user"
                    case .UserFallback:
                        alert.message = "Password not accepted, must use Touch-ID"
                    default:
                        alert.message = "Unable to Authenticate!"
                    }
                    dispatch_async(dispatch_get_main_queue()){
                        //not playing it safe
                        self.presentViewController(alert, animated: true, completion: nil)
                    }
                }
            })
        }
        else {
            //cannot access LA
            alert.title = "Error"
            switch LAError(rawValue: touchIDErr!.code)! {
            case .TouchIDNotEnrolled:
                alert.message = "Touch ID is not enrolled"
                
            case .TouchIDNotAvailable:
                alert.message = "TouchID is not available on the device"
                
            case .PasscodeNotSet:
                alert.message = "Passcode has not been set"
                
            case .InvalidContext:
                alert.message = "The context is invalid"
                
            default:
                alert.message = "Local Authentication not available"
            }
            dispatch_async(dispatch_get_main_queue()){
                //not playing it safe with the closure parameter (look above)
                
                self.presentViewController(alert, animated: true, completion: nil)
            }

        }
    }
}
