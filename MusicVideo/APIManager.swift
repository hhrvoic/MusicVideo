//
//  APIManager.swift
//  MusicVideo
//
//  Created by hrvoje on 12/03/16.
//  Copyright © 2016 hrvoje. All rights reserved.
//

import Foundation

class APIManager {
    func loadData(urlString:String, completion:(result:String) -> Void){
        
        
            let config = NSURLSessionConfiguration.ephemeralSessionConfiguration() //dont use caching (in offline mode)
            let session = NSURLSession(configuration: config)
        
        
            let url = NSURL(string:urlString)! //url creation
            //async thread call for api call
        
            let task = session.dataTaskWithURL(url) {
                    (data,response,error) -> Void in
                        dispatch_async(dispatch_get_main_queue()) { //return to main thread code
                            if error != nil{
                                completion(result:(error!.localizedDescription) )
                            }
                            else { //success
                                completion (result:"NSURLSession successful")
                                print(data)
                            }
                    }
                
                }
            task.resume() //task always start in suspended state, you have to force start manually
        
        }
}