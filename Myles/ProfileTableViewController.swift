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
        let query = CreditApplication.query()
        //        print(PFUser.currentUser()!.objectId!)
        //        let i = PFInstallation.currentInstallation()
        //        query?.whereKey("installation", equalTo: i.objectId!)
        //        query?.whereKeyDoesNotExist("approvedAt")
        //        query?.whereKeyDoesNotExist("declinedAt")
        query?.addDescendingOrder("appliedAt")
        return query!
    }
}