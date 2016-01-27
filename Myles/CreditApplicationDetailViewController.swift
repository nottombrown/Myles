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
        creditApplication["declinedAt"] = nil
        creditApplication["appliedAt"] = NSDate()
        creditApplication.saveEventually()
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
        self.setCorrectView()
    }
    
    func creditApplicationBonusMissed() {
        creditApplication["missedBonusAt"] = NSDate()
        creditApplication.saveEventually()
        self.setCorrectView()
    }
    
    func creditApplicationCanceled() {
        creditApplication["canceledAt"] = NSDate()
        creditApplication.saveEventually()
        self.setCorrectView()
    }
    
    func setCorrectView() {
        for subview in self.stateView.subviews {
            subview.removeFromSuperview()
        }
        
        let bundle = NSBundle.mainBundle()

        if creditApplication["approvedAt"] == nil && creditApplication["declinedAt"] == nil {
            let view = bundle.loadNibNamed("CreditApplicationPending", owner: self, options: nil)[0] as! CreditApplicationPending
            view.delegate = self
            view.creditApplication = creditApplication
            self.stateView.addSubview(view)
            view.frame = stateView.bounds
            print("pending")
        } else if creditApplication["declinedAt"] != nil {
            let view = bundle.loadNibNamed("CreditApplicationDeclined", owner: self, options: nil)[0] as! CreditApplicationDeclined
            view.delegate = self
            view.creditApplication = creditApplication
            self.stateView.addSubview(view)
            view.frame = stateView.bounds
            print("declined")
        } else if creditApplication["deliveredAt"] == nil {
            let view = bundle.loadNibNamed("CreditApplicationApproved", owner: self, options: nil)[0] as! CreditApplicationApproved
            view.delegate = self
            view.creditApplication = creditApplication
            self.stateView.addSubview(view)
            view.frame = stateView.bounds
            print("awaiting delivery")
        } else if creditApplication["hitBonusAt"] == nil && creditApplication["missedBonusAt"] == nil {
            let view = bundle.loadNibNamed("CreditApplicationDelivered", owner: self, options: nil)[0] as! CreditApplicationDelivered
            view.creditApplication = creditApplication
            view.delegate = self
            self.stateView.addSubview(view)
            view.frame = stateView.bounds
            print("delivered")
        } else if creditApplication["canceledAt"] == nil {
            let view = bundle.loadNibNamed("CreditApplicationLive", owner: self, options: nil)[0] as! CreditApplicationLive
            view.creditApplication = creditApplication
            view.delegate = self
            self.stateView.addSubview(view)
            view.frame = stateView.bounds
            print("awaiting cancel")
        } else {
            let view = bundle.loadNibNamed("CreditApplicationCanceled", owner: self, options: nil)[0] as! CreditApplicationCanceled
            view.creditApplication = creditApplication
            self.stateView.addSubview(view)
            view.frame = stateView.bounds
            print("canceled")
        }
        self.view.setNeedsDisplay()
    }
    
    override func viewDidLoad() {

        // Let autolayout use the constraints imposed by Nav and Tab bars
        if self.respondsToSelector("edgesForExtendedLayout") {
            self.edgesForExtendedLayout = .None
        }
        
        super.viewDidLoad()
        self.setCorrectView()
        
        cardImage.file = creditApplication.offer?.image
    }
}