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
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var contentView: UIView!
    
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

        // Let autolayout use the constraints imposed by Nav and Tab bars
        if self.respondsToSelector("edgesForExtendedLayout") {
            self.edgesForExtendedLayout = .None
        }
        
        title = offer.name
        cardImage.file = offer.image
        applyButton.setTitle("Apply for \(offer.name!)", forState: .Normal)
        
        rewardExplanationLabel.attributedText = rewardAttributedString()
        let timeLimit = offer["timeLimit"] as! Int
        let condition = offer["condition"] as! String
        requirementsLabel.text = "\(condition) in \(timeLimit) days. We'll walk you through canceling the card afterwards."
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
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        let aggregateView = contentView.subviews.reduce(CGRect())
            { aggRect, view in aggRect.union(view.frame) }
        
        scrollView.contentSize = aggregateView.size
        
    }
    
    @IBAction func apply(sender: AnyObject) {
        let application = CreditApplication()
        application.ACL = PFACL(user: PFUser.currentUser()!)
        application["user"] = PFUser.currentUser()
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