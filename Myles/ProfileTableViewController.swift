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
        let approvedQuery = CreditApplication.query()
        approvedQuery!.whereKeyExists("approvedAt")
        approvedQuery!.whereKey("user", equalTo: PFUser.currentUser()!)
        approvedQuery!.includeKey("offer")
        approvedQuery!.addDescendingOrder("approvedAt")

        return approvedQuery!
    }
}