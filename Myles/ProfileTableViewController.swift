//
//  ProfileTableViewController.swift
//  Myles
//
//  Created by Finbarr Taylor on 1/20/16.
//  Copyright © 2016 tombarr. All rights reserved.
//

import Foundation
import Parse

class ProfileTableViewController: CreditApplicationsTableViewController {
    
    override func queryForTable() -> PFQuery {
        let approvedQuery = CreditApplication.query()?.whereKeyExists("approvedAt")
        let declinedQuery = CreditApplication.query()?.whereKeyExists("declinedAt")
        
        let query = PFQuery.orQueryWithSubqueries([approvedQuery!,declinedQuery!])
//        print(PFUser.currentUser()!.objectId!)
//        let i = PFInstallation.currentInstallation()
//        query?.whereKey("installation", equalTo: i.objectId!)
        
        // First approved, then declined
        query.addDescendingOrder("approvedAt")
        query.addDescendingOrder("declinedAt")
        return query
    }
}