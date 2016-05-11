//
//  APIManager.swift
//  MusicVideo
//

import Foundation

class APIManager {
    func loadData(urlString:String, completion:(result:[MusicVideo]) -> Void){
        
        
            let config = NSURLSessionConfiguration.ephemeralSessionConfiguration() //dont use caching (in offline mode)
            let session = NSURLSession(configuration: config)
        
        
            let url = NSURL(string:urlString)! //url creation
            //async thread call for api call
        
            let task = session.dataTaskWithURL(url) {
                    (data,response,error) -> Void in
                            if error != nil{ //no need for dispatching to main because we are not gonna show this error in UI (main thread = UI processing)
                                 print (error!.localizedDescription)
                                
                            }
                            else { //success
                                do {
                                    //convert nsdata to JSON and cast it to dictionary, .allow fragments - top level object is not NSdict/NSarray
                                    if let json = try NSJSONSerialization.JSONObjectWithData(data!, options: .AllowFragments) as? JSONDictionary,
                                        feed = json["feed"] as? JSONDictionary,
                                        musicVideosEntries = feed["entry"] as? JSONArray
                                        {
                                            
                                            var musicVideos = [MusicVideo]()
                                            for (index,entry) in musicVideosEntries.enumerate() {
                                                let musicVideo = MusicVideo (data: entry as! JSONDictionary)
                                                musicVideo.vRank = index + 1
                                                musicVideos.append(musicVideo)
                                            }
                                            let priority = DISPATCH_QUEUE_PRIORITY_HIGH
                                            //we are currently in global (background) thread queue, setting the high priority means we will faster get out of it - this background job will have high priority compared to other background jobs
                                            dispatch_async(dispatch_get_global_queue(priority,0)) {
                                                //high priority (bg) code = dispatching to main
                                                dispatch_async(dispatch_get_main_queue()) {
                                                    completion(result: musicVideos)
                                                }
                                            }
                                        }
                                }
                                catch {
                                    dispatch_async(dispatch_get_main_queue()) {
                                        completion(result: [MusicVideo]() )
                                    }
 
                                }
                                
                            }
                    }
        
            task.resume() //task always start in suspended state, you have to force start manually
        
        }
}