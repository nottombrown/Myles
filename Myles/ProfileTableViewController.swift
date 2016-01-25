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
        let approvedQuery = CreditApplication.query()?.whereKeyExists("approvedAt").whereKey("uuid", equalTo: User.uuid())
        approvedQuery!.includeKey("offer")
        approvedQuery!.addDescendingOrder("approvedAt")

        return approvedQuery!
    }
}