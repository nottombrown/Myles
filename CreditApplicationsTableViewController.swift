//
//  CreditApplicationsTableViewController.swift
//  Myles
//
//  Created by Finbarr Taylor on 1/20/16.
//  Copyright © 2016 tombarr. All rights reserved.
//

import Foundation
import Parse

class CreditApplicationsTableViewController: MylesTableViewController {

    override func queryForTable() -> PFQuery {
        let query = CreditApplication.query()
        query?.includeKey("offer")
        query?.whereKey("user", equalTo: PFUser.currentUser()!)
        query?.whereKeyDoesNotExist("approvedAt")
        query?.addDescendingOrder("appliedAt")
        return query!
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.registerNib(UINib(nibName: "CreditApplicationTableViewCell", bundle: NSBundle.mainBundle()), forCellReuseIdentifier: "CreditCell")
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath, object: PFObject!) -> PFTableViewCell? {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("CreditCell", forIndexPath: indexPath) as! CreditApplicationTableViewCell
        
        let creditApp = object as! CreditApplication
        
        if let appliedAt = creditApp.appliedAt {
            cell.appliedAtLabel.text = "Applied \(timeAgoSinceDate(appliedAt, numericDates: false).lowercaseString)"
        }        
        
        if let offer = creditApp.offer {
            cell.cardImage.file = offer.image
            cell.cardImage.loadInBackground(nil)
            
            print(offer.name)
            
            cell.nameLabel.text = offer.name
        }
        
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let creditApp = objectAtIndexPath(indexPath) as! CreditApplication
        let creditApplicationDetailViewController = CreditApplicationDetailViewController(creditApplication: creditApp)
        navigationController?.pushViewController(creditApplicationDetailViewController, animated: true)
    }
}