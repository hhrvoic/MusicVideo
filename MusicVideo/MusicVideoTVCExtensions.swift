//
//  MusicVideoTVCExtensions.swift
//  MusicVideo
//
//  Created by FOI on 07/07/16.
//  Copyright © 2016 hrvoje. All rights reserved.
//

import UIKit


extension MusicVideoTVC : UISearchResultsUpdating {
    func updateSearchResultsForSearchController(searchController: UISearchController) {
        searchController.searchBar.text?.lowercaseString
        filterSearch(searchController.searchBar.text!)
        
    }
}
