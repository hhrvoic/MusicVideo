//
//  ViewController.swift
//  MusicVideo
//
//  Created by hrvoje on 12/03/16.
//  Copyright © 2016 hrvoje. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
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
    

}

