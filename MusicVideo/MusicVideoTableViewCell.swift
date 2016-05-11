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

    
    
    
    func updateCell() {
       rankLabel.text = ("\(video!.vRank)")
       titleLabel.text = video!.vName
        musicVideoImage.image = UIImage(named: "imageNotAvailable")
    }

    }
