//
//  OffersTableViewController.swift
//  Myles
//
//  Created by Tom Brown on 1/20/16.
//  Copyright © 2016 tombarr. All rights reserved.
//

import Foundation
import Parse

// TODO: rename to OfferTableViewController
class OffersTableViewController: MylesTableViewController {
    
    override func queryForTable() -> PFQuery {
        let query = Offer.query()
        query?.addAscendingOrder("goodness")
        let q2 = CreditApplication.query()
        q2?.whereKey("user", equalTo: PFUser.currentUser()!)
        query?.whereKey("objectId", doesNotMatchKey: "offerId", inQuery: q2!)
        return query!
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Register the table view prototype cell
        tableView.registerNib(UINib(nibName: "OfferTableViewCell", bundle: nil), forCellReuseIdentifier: "OfferCell")
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath, object: PFObject!) -> PFTableViewCell? {

        let cell = tableView.dequeueReusableCellWithIdentifier("OfferCell", forIndexPath: indexPath) as! OfferTableViewCell
        
        let offer = object as! Offer

        cell.cardImage.file = offer.image
        cell.cardImage.loadInBackground(nil)
        
        cell.nameLabel.text = offer.name
        cell.rewardLabel.text = "\(offer.reward!) Reward"
        
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let offer = objectAtIndexPath(indexPath) as! Offer
        let offerDetailViewController = OfferDetailViewController(offer: offer)
        navigationController?.pushViewController(offerDetailViewController, animated: true)
    }
}
