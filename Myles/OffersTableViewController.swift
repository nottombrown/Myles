//
//  OffersTableViewController.swift
//  Myles
//
//  Created by Tom Brown on 1/20/16.
//  Copyright © 2016 tombarr. All rights reserved.
//

import Foundation
import Parse

class OffersTableViewController: PFQueryTableViewController {

    override func viewWillAppear(animated: Bool) {
        print("OffersTVC")
        loadObjects()
    }

    
    override func queryForTable() -> PFQuery {
        let query = Offer.query()
        return query!
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Register the table view prototype cell
        tableView.registerClass(OfferTableViewCell.self, forCellReuseIdentifier: "OfferCell")
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath, object: PFObject!) -> PFTableViewCell? {
        // 1
        let cell = tableView.dequeueReusableCellWithIdentifier("OfferCell", forIndexPath: indexPath) as! OfferTableViewCell
        
        // 2
        let offer = object as! Offer
        
        // 3 print our image loading progress
        cell.cardImage.file = offer.image
        cell.cardImage.loadInBackground(nil) { percent in
//            cell.progressView.progress = Float(percent)*0.01
//            println("\(percent)%")
        }
        
        // 4
        cell.nameLabel.text = offer.name
        
        cell.rewardLabel.text = offer.reward
        
        return cell
    }
    
    
}