//
//  MusicVideoTableViewCell.swift
//  MusicVideo
//
//  Created by hrvoje on 19/03/16.
//  Copyright © 2016 hrvoje. All rights reserved.
//

import UIKit

class MusicVideoTableViewCell: UITableViewCell {

    //always do the logic in the custom cell not in the TVC, make an public var and call the cell content updating after setting the var (setter observer)
    var video : MusicVideo? {
        didSet {
            updateCell()
        }
    }
    @IBOutlet weak var musicVideoImage: UIImageView!
    @IBOutlet weak var rankLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    
    func updateCell() {
        rankLabel.text = ("\(video?.vRank)")
        titleLabel.text = video?.vName
        musicVideoImage.image = UIImage(named: "imageNotAvailable")
    }

}
