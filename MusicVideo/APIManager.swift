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
                            if error != nil{
                                 dispatch_async(dispatch_get_main_queue()) { //return to main thread code
                                completion(result:(error!.localizedDescription) )
                                }
                            }
                            else { //success
                                do {
                                    //convert nsdata to JSON and cast it to dictionary, .allow fragments - top level object is not NSdict/NSarray
                                    if let json = try NSJSONSerialization.JSONObjectWithData(data!, options: .AllowFragments) as? [String: AnyObject]
                                        {
                                            
                                            let priority = DISPATCH_QUEUE_PRIORITY_HIGH
                                            //we are currently in global (background) thread queue, setting the high priority means we will faster get out of it - this background job will have high priority compared to other background jobs
                                            dispatch_async(dispatch_get_global_queue(priority,0)) {
                                                //high priority (bg) code = dispatching to main
                                                dispatch_async(dispatch_get_main_queue()) {
                                                    completion(result: "JSON serialization succesfull")
                                                }
                                            }
                                        }
                                }
                                catch {
                                    dispatch_async(dispatch_get_main_queue()) {
                                        completion(result: "Error in JSON serialization")
                                    }
 
                                }
                                
                            }
                    }
        
            task.resume() //task always start in suspended state, you have to force start manually
        
        }
}