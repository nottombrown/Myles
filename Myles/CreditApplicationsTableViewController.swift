//
//  CreditApplicationsTableViewController.swift
//  Myles
//
//  Created by Finbarr Taylor on 1/20/16.
//  Copyright © 2016 tombarr. All rights reserved.
//

import Foundation
import Parse

class CreditApplicationsTableViewController: PFQueryTableViewController {
    override func viewWillAppear(animated: Bool) {
        loadObjects()
    }
    
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("LOADED")
        self.tableView.registerNib(UINib(nibName: "CreditApplicationTableViewCell", bundle: NSBundle.mainBundle()), forCellReuseIdentifier: "CreditCell")
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath, object: PFObject!) -> PFTableViewCell? {
        
        // 1
        let cell = tableView.dequeueReusableCellWithIdentifier("CreditCell", forIndexPath: indexPath) as! CreditApplicationTableViewCell
        
        // 2
        let app = object as! CreditApplication
        
        if let offer = app.offer {
        
            // 3 print our image loading progress
            cell.cardImage.file = offer.image
            cell.cardImage.loadInBackground(nil)
            
            print(offer.name)
            
            cell.nameLabel.text = offer.name
            
            cell.appliedAtLabel.text = String(app.appliedAt)
        }
        
        return cell
    }
}