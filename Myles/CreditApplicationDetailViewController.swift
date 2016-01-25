//
//  CreditApplicationDetailViewController.swift
//  Myles
//
//  Created by Tom Brown on 1/20/16.
//  Copyright © 2016 tombarr. All rights reserved.
//

import Foundation

class CreditApplicationDetailViewController: UIViewController, CreditApplicationPendingDelegate, CreditApplicationApprovedDelegate, CreditApplicationDeliveredDelegate, CreditApplicationLiveDelegate {
    
    let creditApplication: CreditApplication
    
    init(creditApplication: CreditApplication) {
        self.creditApplication = creditApplication
        super.init(nibName: nil, bundle: nil)
    }
    
    required init(coder: NSCoder) {
        // http://stackoverflow.com/questions/25126295/swift-class-does-not-implement-its-superclasss-required-members
        fatalError("NSCoding not supported")
    }
    
    func creditApplicationDeclined() {
        creditApplication["declinedAt"] = NSDate()
        creditApplication.saveEventually()
    }
    
    func creditApplicationApproved() {
        creditApplication["approvedAt"] = NSDate()
        creditApplication.saveEventually()
    }
    
    func creditApplicationDelivered() {
        creditApplication["deliveredAt"] = NSDate()
        creditApplication.saveEventually()
    }
    
    func creditApplicationBonusHit() {
        creditApplication["hitBonusAt"] = NSDate()
        creditApplication.saveEventually()
    }
    
    func creditApplicationBonusMissed() {
        creditApplication["missedBonusAt"] = NSDate()
        creditApplication.saveEventually()
    }
    
    func creditApplicationCanceled() {
        creditApplication["canceledAt"] = NSDate()
        creditApplication.saveEventually()
    }
    
    func setCorrectView() {
    }
    
    override func viewDidLoad() {
        title = creditApplication.offer?.name
        self.setCorrectView()
    }
}