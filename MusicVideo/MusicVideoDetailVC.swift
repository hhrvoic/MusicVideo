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

class MusicVideoDetailVC: UIViewController {

    @IBOutlet weak var vImageView: UIImageView!
    @IBOutlet weak var vNameLabel: UILabel!
    @IBOutlet weak var vGenreLabel: UILabel!
    @IBOutlet weak var vCostLabel: UILabel!
    @IBOutlet weak var vRightsLabel: UILabel!
    
    var video : MusicVideo!
    
    
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
        shareMedia()
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
}
