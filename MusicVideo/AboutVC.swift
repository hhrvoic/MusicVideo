//
//  AboutVC.swift
//  MusicVideo
//
//  Created by FOI on 23/06/16.
//  Copyright © 2016 hrvoje. All rights reserved.
//

import UIKit

class AboutVC: UIViewController, UITableViewDataSource, UITableViewDelegate {

   
    @IBOutlet weak var asd: UILabel!
    
    @IBOutlet weak var webView: UIWebView!

    override func viewDidLoad() {
        title = "About"
        let url = NSURL(string : "https://github.com/hhrvoic/MusicVideo")
        let request = NSURLRequest(URL: url!)
        webView.loadRequest(request)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "preferedFontChange", name: UIContentSizeCategoryDidChangeNotification, object: nil)
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2;
    }
    
    // Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
    // Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)
    

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
            let id = String(indexPath.row)
            let identifier = "cell"+id
            return tableView.dequeueReusableCellWithIdentifier(identifier,forIndexPath: indexPath)
    }
    func preferedFontChange(){

//          lblAppName.font = UIFont.preferredFontForTextStyle(UIFontTextStyleSubheadline)
//          lblAppVer.font = UIFont.preferredFontForTextStyle(UIFontTextStyleSubheadline)
//          lblName.font =  UIFont.preferredFontForTextStyle(UIFontTextStyleSubheadline)
//          lblVer.font = UIFont.preferredFontForTextStyle(UIFontTextStyleSubheadline)
        
        
    }

    
   }
