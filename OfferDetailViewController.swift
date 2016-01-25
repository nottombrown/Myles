//
//  OfferDetailViewController.swift
//  Myles
//
//  Created by Tom Brown on 1/20/16.
//  Copyright © 2016 tombarr. All rights reserved.
//

import Foundation

class OfferDetailViewController: UIViewController {
    @IBOutlet weak var nameLabel: UILabel!
    
    let offer: Offer
    
    init(offer: Offer) {
        self.offer = offer
        super.init(nibName: nil, bundle: nil)
    }
    
    required init(coder: NSCoder) {
        // http://stackoverflow.com/questions/25126295/swift-class-does-not-implement-its-superclasss-required-members
        fatalError("NSCoding not supported")
    }
    
    override func viewDidLoad() {
        title = offer.name
        nameLabel.text = "\(offer.name!) Details"
    }
    
    @IBAction func apply(sender: AnyObject) {
        let application = CreditApplication()
        application["uuid"] = User.uuid()
        application["offer"] = offer
        application["appliedAt"] = NSDate()
        application.saveInBackgroundWithBlock { (saved, e) -> Void in
            if saved {
                let link = self.offer["link"] as! String!
                UIApplication.sharedApplication().openURL(NSURL(string: link)!)
                // redirect to this credit application
            } else {
                // some error
            }
        }
    }
}