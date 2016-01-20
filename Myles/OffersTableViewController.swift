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
class OffersTableViewController: PFQueryTableViewController {
    
    
    override func viewWillAppear(animated: Bool) {
        print("OffersTVC")
        loadObjects()
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 84.0
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let offer = objectAtIndexPath(indexPath) as! Offer
        // Present with: http://stackoverflow.com/questions/27326183/presenting-a-view-controller-programmatically-in-swift
        
        
        let offerDetailViewController = OfferDetailViewController(offer: offer)
        
        navigationController?.pushViewController(offerDetailViewController, animated: true)
    }
    
    override func queryForTable() -> PFQuery {
        let query = Offer.query()
        query?.addAscendingOrder("goodness")
        //        let i = PFInstallation.currentInstallation()
        
        //        let q2 = CreditApplication.query()
        //        q2?.whereKey("installation", equalTo: i.objectId!)
        //        query?.whereKey("objectId", doesNotMatchKey: "offer", inQuery: q2!)
        
        return query!
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Register the table view prototype cell
        tableView.registerNib(UINib(nibName: "OfferTableViewCell", bundle: nil), forCellReuseIdentifier: "OfferCell")
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath, object: PFObject!) -> PFTableViewCell? {
        // 1
        let cell = tableView.dequeueReusableCellWithIdentifier("OfferCell", forIndexPath: indexPath) as! OfferTableViewCell
        
        // 2
        let offer = object as! Offer
        
        // 3
        cell.cardImage.file = offer.image
        cell.cardImage.loadInBackground(nil)
        
        print(offer.name)
        print(offer.reward)
        print(cell)
        
        cell.nameLabel.text = offer.name
        cell.rewardLabel.text = "\(offer.reward!) Reward"
        
        return cell
    }
    
    
    
}
