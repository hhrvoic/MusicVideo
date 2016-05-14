//
//  MusicVideoTableViewCell.swift
//  MusicVideo
//
//  Created by hrvoje on 19/03/16.
//  Copyright © 2016 hrvoje. All rights reserved.
//

import UIKit

class MusicVideoTableViewCell: UITableViewCell {

   
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var musicVideoImage: UIImageView!
  
    @IBOutlet weak var rankLabel: UILabel!
    var video : MusicVideo? {
        didSet {
             updateCell()
            
        }
    }
    
    func getImageData(video:MusicVideo, imageView:UIImageView){
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT,0)){
        
        let data = NSData(contentsOfURL: NSURL(string: video.vImageUrl)!)
        var image : UIImage?
            if let bytes = data {
                  video.vImageData = bytes
                  image = UIImage(data:bytes)
            }
            dispatch_async(dispatch_get_main_queue()){
                imageView.image = image
                
            }
        }
       
        
    }
    
    
    
    func updateCell() {
       rankLabel.text = ("\(video!.vRank)")
       titleLabel.text = video!.vName
        if let imgData = video!.vImageData { //optional binding
            musicVideoImage.image = UIImage (data: imgData)
            print("getting image from previously stored nsdata...")
        }
        else {
            musicVideoImage.image = UIImage(named: "imageNotAvailable")
            print("getting image from url for the first time/backgorund thread")
            getImageData(video!, imageView: musicVideoImage)
        }
    }

    }
