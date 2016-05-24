//
//  MusicVideoDetailVC.swift
//  MusicVideo
//
//  Created by FOI on 14/05/16.
//  Copyright © 2016 hrvoje. All rights reserved.
//

import UIKit

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
    }

 
}
