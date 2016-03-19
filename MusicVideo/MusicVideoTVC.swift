//
//  MusicVideoTVC.swift
//  MusicVideo
//
//  Created by hrvoje on 18/03/16.
//  Copyright © 2016 hrvoje. All rights reserved.
//

import UIKit

class MusicVideoTVC: UITableViewController {
 
    var videos =  [MusicVideo] ()
    override func viewDidLoad() {
        
        super.viewDidLoad()
       
        NSNotificationCenter.defaultCenter().addObserver(self, selector:"reachabilityStatusChanged", name: "ReachStatusChanged", object: nil) //listen for notification which is posted in app delegate
        reachabilityStatusChanged()
        
        let api = APIManager ()
        api.loadData("https://itunes.apple.com/us/rss/topmusicvideos/limit=50/json", completion: didLoadData)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func didLoadData(result:[MusicVideo]){ //check the data
        videos = result
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
         tableView.reloadData()
    }
    func reachabilityStatusChanged() {
        switch reachabilityStatus {
        case NOACCESS:
            view.backgroundColor = UIColor.redColor()
            //displayLabel.text = "No internet connection"
        case WIFI:
            view.backgroundColor = UIColor.yellowColor()
            //displayLabel.text = "Connected on WIFI"
        case WWAN: view.backgroundColor = UIColor.greenColor()
        //displayLabel.text = "Connected on mobile data"
        default:return
        }
    }
    
    deinit { //when closing viewcontroller (deinitialization) remove observer
        NSNotificationCenter.defaultCenter().removeObserver(self, name:"ReachStatusChanged", object: nil)
    }
    
  

    // MARK: - Table view data source

    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return videos.count
    }
    
    // Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
    // Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath)
        let video = videos[indexPath.row]
        cell.textLabel?.text = ("\(indexPath.row + 1)")
        cell.detailTextLabel?.text = video.vName
        return cell
    }
    
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    } // Default is 1 if not implemented

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
