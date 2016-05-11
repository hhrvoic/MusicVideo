//
//  MusicVideo.swift
//  MusicVideo
//


import Foundation

class MusicVideo {
    
    var vRank = 0 
    private var _vName: String
    private var _vImageUrl:String
    private var _vVideoUrl:String
    private var _vRights:String
    private var _vPrice:String
    private var _vArtist:String
    private var _vImId:String
    private var _vGenre:String
    private var _vLinkToiTunes:String
    private var _vReleaseDate:String
    
    var vImageData: NSData? //image that is stored after one and only time network fetching
    var vName:String {
        return _vName
    }
    var vImageUrl:String {
        return _vImageUrl
    }
    var vVideoUrl:String {
        return _vVideoUrl
    }
    var vArtist:String {
        return _vArtist
    }
    var vImId:String {
        return _vImId
    }
    var vGenre:String {
        return _vGenre
    }
    var vLinkToiTunes:String {
        return _vLinkToiTunes
    }
    var vRights: String {
        return _vRights
    }
    var vPrice: String {
        return _vPrice
    }
    var vReleaseDate: String {
        return _vReleaseDate
    }
    
    init(data: JSONDictionary) { //? is optional downcast, ! is forced downcast
        if let name = data["im:name"] as? JSONDictionary, vName = name["label"] as? String {
                self._vName = vName
            }
        else { //in case of api fail
            _vName = ""
        }
        
        if let imgArray = data["im:image"] as? JSONArray, vImageUrlDict = imgArray[2] as? JSONDictionary, vImageUrl = vImageUrlDict["label"] {
            _vImageUrl = vImageUrl.stringByReplacingOccurrencesOfString("100x100", withString: "600x600")
        }
        else {
            _vImageUrl = ""
        }
        
        if let linkArray = data["link"] as? JSONArray,
        linkDict = linkArray [1] as? JSONDictionary,
        let attributes = linkDict["attributes"] as? JSONDictionary,
        vVideoUrl = attributes["href"] as? String {
            _vVideoUrl = vVideoUrl
        }
        else {
            _vVideoUrl = ""
        }
        
        if let rights = data["rights"] as? JSONDictionary, vRights = rights["label"] as? String {
            _vRights = vRights
        }
        else {
            _vRights = ""
        }
        
        if let price = data["im:price"] as? JSONDictionary, vPrice = price["label"] as? String {
            _vPrice = vPrice
        }
        else {
            _vPrice = ""
        }
        
        if let artist = data["im:artist"] as? JSONDictionary, vArtist = artist["label"] as? String {
            _vArtist = vArtist
        }
        else {
            _vArtist = ""
        }
        //imid,genre,linktoitunes,release date
        if let imId = data["id"] as? JSONDictionary, let imIdAttributes = imId["attributes"] as? JSONDictionary, vImId = imIdAttributes["im:id"] as? String  {
            _vImId = vImId
        }
        else {
            _vImId = ""
        }
        
        if let genre = data["category"] as? JSONDictionary, let categoryAttributes = genre["attributes"] as? JSONDictionary, vGenre = categoryAttributes["label"] as? String{
            _vGenre = vGenre
        }
        else {
            _vGenre = ""
        }
        if let linkArray = data["link"] as? JSONArray,
            linkDict = linkArray [0] as? JSONDictionary,
            let attributes = linkDict["attributes"] as? JSONDictionary,
            vLinkToiTunes = attributes["href"] as? String {
                _vLinkToiTunes = vLinkToiTunes
                
        }
        else {
            _vLinkToiTunes = ""
        }
        if let releaseDate = data["im:releaseDate"] as? JSONDictionary, let releaseDateAttributes = releaseDate["attributes"] as? JSONDictionary, vReleaseDate = releaseDateAttributes["label"] as? String  {
            _vReleaseDate = vReleaseDate
        }
        else {
            _vReleaseDate = ""
        }
        
    }

}