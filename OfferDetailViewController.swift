//
//  OfferDetailViewController.swift
//  Myles
//
//  Created by Tom Brown on 1/20/16.
//  Copyright © 2016 tombarr. All rights reserved.
//

import Foundation

class OfferDetailViewController: UIViewController {
    @IBOutlet weak var cardImage: PFImageView!
    @IBOutlet weak var applyButton: UIButton!
    @IBOutlet weak var requirementsLabel: UILabel!
    @IBOutlet weak var rewardExplanationLabel: UILabel!
    
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

        if self.respondsToSelector("edgesForExtendedLayout") {
            self.edgesForExtendedLayout = .None
        }

        
        title = offer.name
        cardImage.file = offer.image
        applyButton.setTitle("Apply for \(offer.name!)", forState: .Normal)
        
        rewardExplanationLabel.attributedText = rewardAttributedString()
        requirementsLabel.text = "\(offer.condition ?? "All you need is to be approved"). We'll walk you through canceling the card afterwards."
    }
    
    func rewardAttributedString() -> NSAttributedString {
        let boldText  = "\(offer.reward!) in miles. "
        let normalText = "It takes 10 minutes to convert them into Amazon credit."
        let attributedString = NSMutableAttributedString(string:normalText)

        let attributes = [NSFontAttributeName : UIFont.boldSystemFontOfSize(15), NSForegroundColorAttributeName : UIColor.blackColor() ]
        let boldString = NSMutableAttributedString(string: boldText, attributes: attributes)
        boldString.appendAttributedString(attributedString)
        return boldString
    }
    
    @IBAction func apply(sender: AnyObject) {
        let application = CreditApplication()
        application["uuid"] = User.uuid()
        application["offer"] = offer
        application["offerId"] = offer.objectId
        application["appliedAt"] = NSDate()
        application.saveInBackgroundWithBlock { (saved, e) -> Void in
            if saved {
                let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
                appDelegate.navigateToPendingApplication(application, offer: self.offer)
            } else {
                // some error
            }
        }
    }
}