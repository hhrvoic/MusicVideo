//
//  ViewController.swift
//  MusicVideo
//
//  Created by hrvoje on 12/03/16.
//  Copyright © 2016 hrvoje. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var displayLabel: UILabel!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        NSNotificationCenter.defaultCenter().addObserver(self, selector:"reachabilityStatusChanged", name: "ReachStatusChanged", object: nil) //listen for notification which is posted in app delegate
        reachabilityStatusChanged()
        
        let api = APIManager ()
        api.loadData("https://itunes.apple.com/us/rss/topmusicvideos/limit=10/json", completion: didLoadData)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func didLoadData(result:[MusicVideo]){ //check the data
        print(reachabilityStatus)
        for (index, video) in result.enumerate() {
            print(index, video.vName)
            print(video.vImageUrl)
            print(video.vVideoUrl)
            print(video.vImId)
            print(video.vArtist)
            print(video.vGenre)
            print(video.vLinkToiTunes)
            print(video.vPrice)
            print(video.vRights)
            print(video.vReleaseDate)
            
        }
        
    }
    func reachabilityStatusChanged() {
        switch reachabilityStatus {
            case NOACCESS:
                view.backgroundColor = UIColor.redColor()
                displayLabel.text = "No internet connection"
            case WIFI:
                view.backgroundColor = UIColor.yellowColor()
                displayLabel.text = "Connected on WIFI"
            case WWAN: view.backgroundColor = UIColor.greenColor()
                displayLabel.text = "Connected on mobile data"
            default:return
        }
    }
    
    deinit { //when closing viewcontroller (deinitialization) remove observer
        NSNotificationCenter.defaultCenter().removeObserver(self, name:"ReachStatusChanged", object: nil)
    }

}

