//
//  CreditApplicationDetailViewController.swift
//  Myles
//
//  Created by Tom Brown on 1/20/16.
//  Copyright © 2016 tombarr. All rights reserved.
//

import Foundation

class CreditApplicationDetailViewController: UIViewController, CreditApplicationPendingDelegate, CreditApplicationDeclinedDelegate, CreditApplicationApprovedDelegate, CreditApplicationDeliveredDelegate, CreditApplicationLiveDelegate {
    @IBOutlet weak var cardImage: PFImageView!
    @IBOutlet weak var stateView: UIView!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var contentView: UIView!
    
    let creditApplication: CreditApplication
    
    init(creditApplication: CreditApplication) {
        self.creditApplication = creditApplication
        super.init(nibName: nil, bundle: nil)
    }
    
    required init(coder: NSCoder) {
        // http://stackoverflow.com/questions/25126295/swift-class-does-not-implement-its-superclasss-required-members
        fatalError("NSCoding not supported")
    }
    
    func creditApplicationReapplied() {
        creditApplication["declinedAt"] = NSNull()
        creditApplication["appliedAt"] = NSDate()
        creditApplication.saveEventually()
        let offer = creditApplication["offer"] as! Offer
        let link = offer["link"] as! String!
        UIApplication.sharedApplication().openURL(NSURL(string: link)!)
        self.setCorrectView()
    }
    
    func creditApplicationDeclined() {
        creditApplication["declinedAt"] = NSDate()
        creditApplication.saveEventually()
        self.setCorrectView()
    }
    
    func creditApplicationApproved() {
        creditApplication["approvedAt"] = NSDate()
        creditApplication.saveEventually()
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        appDelegate.navigateToApprovedApplication(creditApplication)
    }
    
    func creditApplicationDelivered() {
        creditApplication["deliveredAt"] = NSDate()
        creditApplication.saveEventually()
        self.setCorrectView()
    }
    
    func creditApplicationBonusHit() {
        creditApplication["hitBonusAt"] = NSDate()
        creditApplication.saveEventually()
        alert("Woohoo!", message: "You're awesome.", actionTitle: "I know.")
        self.setCorrectView()
    }
    
    func creditApplicationBonusMissed() {
        creditApplication["missedBonusAt"] = NSDate()
        creditApplication.saveEventually()
        alert("Man...", message: "Get your shit together.", actionTitle: "Boohoo.")
        self.setCorrectView()
    }
    
    func creditApplicationCanceled() {
        creditApplication["canceledAt"] = NSDate()
        creditApplication.saveEventually()
        self.setCorrectView()
    }
    
    func renderStateView(view:UIView!) {
        view.frame.size = stateView.bounds.size
        self.stateView.addSubview(view)
    }
    
    func alert(title:String!, message:String!, actionTitle:String!) {
        let a = UIAlertController(title: title, message:message, preferredStyle: .Alert)
        a.addAction(UIAlertAction(title: actionTitle, style: .Default) { _ in })
        self.presentViewController(a, animated: true){}
    }
    
    func setCorrectView() {
        for subview in self.stateView.subviews {
            subview.removeFromSuperview()
        }
        
        let bundle = NSBundle.mainBundle()

        if creditApplication["approvedAt"] as? NSDate == nil && creditApplication["declinedAt"] as? NSDate == nil {
            let view = bundle.loadNibNamed("CreditApplicationPending", owner: self, options: nil)[0] as! CreditApplicationPending
            view.delegate = self
            view.creditApplication = creditApplication
            renderStateView(view)
            print("pending")
        } else if creditApplication["declinedAt"] as? NSDate != nil {
            let view = bundle.loadNibNamed("CreditApplicationDeclined", owner: self, options: nil)[0] as! CreditApplicationDeclined
            view.delegate = self
            view.creditApplication = creditApplication
            let appliedAt = creditApplication["appliedAt"] as! NSDate
            let reapplyAt = appliedAt.dateByAddingTimeInterval(180*(24*60*60))
            let ti = reapplyAt.timeIntervalSinceNow
            let days = Int(ceil(ti / (24*60*60)))
            if ti <= 0 || (days < 7) {
                view.declinedInstructionLabel.text = "You should reapply for this card!"
            } else {
                view.declinedInstructionLabel.text = "Sorry you got declined. It happens all the time. You should reapply in \(days) days."
            }
            renderStateView(view)
            print("declined")
        } else if creditApplication["deliveredAt"] as? NSDate == nil {
            let view = bundle.loadNibNamed("CreditApplicationApproved", owner: self, options: nil)[0] as! CreditApplicationApproved
            view.delegate = self
            view.creditApplication = creditApplication
            renderStateView(view)
            print("awaiting delivery")
        } else if creditApplication["hitBonusAt"] as? NSDate == nil && creditApplication["missedBonusAt"] as? NSDate == nil {
            let view = bundle.loadNibNamed("CreditApplicationDelivered", owner: self, options: nil)[0] as! CreditApplicationDelivered
            let offer = creditApplication["offer"] as! Offer
            let timeLimit = offer["timeLimit"] as! Int
            let approvedAt = creditApplication["approvedAt"] as! NSDate
            let offerEndsAt = approvedAt.dateByAddingTimeInterval(NSTimeInterval(timeLimit*24*60*60))
            let ti = offerEndsAt.timeIntervalSinceNow
            let days = Int(ceil(ti / (24*60*60)))
            let s = (offer["condition"] as! String).lowercaseString
            
            if ti <= 0 {
                view.bonusInstructionLabel.text = "You are out of time to \(s). Did you hit the bonus?"
            } else {
                if days < 2 {
                    view.bonusInstructionLabel.text = "You have 1 day left to \(s)! Complete this to earn the bonus of \(offer.reward!)."
                } else {
                    view.bonusInstructionLabel.text = "You have \(days) days left to \(s). Complete this to earn the bonus of \(offer.reward!)."
                }
            }
            
            view.creditApplication = creditApplication
            view.delegate = self
            renderStateView(view)
            print("delivered")
        } else if creditApplication["canceledAt"] as? NSDate == nil {
            let view = bundle.loadNibNamed("CreditApplicationLive", owner: self, options: nil)[0] as! CreditApplicationLive
            let approvedAt = creditApplication["approvedAt"] as! NSDate
            let feeAt = approvedAt.dateByAddingTimeInterval(360*(24*60*60))
            
            let formatter = NSDateFormatter()
            formatter.dateStyle = .MediumStyle
            formatter.timeStyle = .MediumStyle
            
            
            view.cancelInstructionLabel.text = "Remember to cancel this card before \(formatter.stringFromDate(feeAt))."
            view.creditApplication = creditApplication
            view.delegate = self
            renderStateView(view)
            print("awaiting cancel")
        } else {
            let view = bundle.loadNibNamed("CreditApplicationCanceled", owner: self, options: nil)[0] as! CreditApplicationCanceled
            view.creditApplication = creditApplication
            renderStateView(view)
            print("canceled")
        }
        self.view.setNeedsDisplay()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        let aggregateView = contentView.subviews.reduce(CGRect())
            { aggRect, view in aggRect.union(view.frame) }
        scrollView.contentSize = aggregateView.size
    }
    
    override func viewDidLoad() {

        // Let autolayout use the constraints imposed by Nav and Tab bars
        if self.respondsToSelector("edgesForExtendedLayout") {
            self.edgesForExtendedLayout = .None
        }
        
        super.viewDidLoad()
        self.setCorrectView()
        
        cardImage.file = creditApplication.offer?.image
        cardImage.loadInBackground()
    }
}