//
//  CreditApplicationDetailViewController.swift
//  Myles
//
//  Created by Tom Brown on 1/20/16.
//  Copyright © 2016 tombarr. All rights reserved.
//

import Foundation

class CreditApplicationDetailViewController: UIViewController, CreditApplicationPendingDelegate, CreditApplicationDeclinedDelegate, CreditApplicationApprovedDelegate, CreditApplicationDeliveredDelegate, CreditApplicationLiveDelegate {
    
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
        self.setCorrectView()
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

        if creditApplication["approvedAt"] == nil && creditApplication["declinedAt"] == nil {
            let view = CreditApplicationPending(creditApplication: creditApplication)
            view.delegate = self
            self.stateView.addSubview(view)
            print("pending")
        } else if creditApplication["declinedAt"] != nil {
            let view = CreditApplicationDeclined(creditApplication: creditApplication)
            view.delegate = self
            self.stateView.addSubview(view)
            print("declined")
        } else if creditApplication["deliveredAt"] == nil {
            let view = CreditApplicationApproved(creditApplication: creditApplication)
            view.delegate = self
            self.stateView.addSubview(view)
            print("awaiting delivery")
        } else if creditApplication["hitBonusAt"] == nil && creditApplication["missedBonusAt"] == nil {
            let view = CreditApplicationDelivered(creditApplication: creditApplication)
            view.delegate = self
            self.stateView.addSubview(view)
            print("delivered")
        } else if creditApplication["canceledAt"] == nil {
            let view = CreditApplicationLive(creditApplication: creditApplication)
            view.delegate = self
            self.stateView.addSubview(view)
            print("awaiting cancel")
        } else {
            let view = CreditApplicationCanceled(creditApplication: creditApplication)
            self.stateView.addSubview(view)
            print("canceled")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setCorrectView()
    }
}