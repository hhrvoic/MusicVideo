//
//  MusicVideo.swift
//  MusicVideo
//


import Foundation

//plain object class that stores all needed properties
class MusicVideo {
    
    private(set) var vRank: Int
    private(set) var vName: String
    private(set) var vImageUrl:String
    private(set) var vVideoUrl:String
    private(set) var vRights:String
    private(set) var vPrice:String
    private(set) var vArtist:String
    private(set) var vImId:String
    private(set) var vGenre:String
    private(set) var vLinkToiTunes:String
    private(set) var vReleaseDate:String
    
    
    init(vRank:Int, vName:String, vRights:String, vPrice:String,
        vImageUrl:String, vArtist:String, vVideoUrl:String, vImid:String,
        vGenre:String, vLinkToiTunes:String, vReleaseDte:String) {
            
            
            self.vRank = vRank
            self.vName = vName
            self.vRights = vRights
            self.vPrice = vPrice
            self.vImageUrl = vImageUrl
            self.vArtist = vArtist
            self.vVideoUrl = vVideoUrl
            self.vImId = vImid
            self.vGenre = vGenre
            self.vLinkToiTunes = vLinkToiTunes
            self.vReleaseDate = vReleaseDte
            
    }
   var vImageData: NSData? //image that is stored after one and only time network fetching

}