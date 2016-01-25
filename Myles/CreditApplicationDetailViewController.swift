//
//  CreditApplicationDetailViewController.swift
//  Myles
//
//  Created by Tom Brown on 1/20/16.
//  Copyright © 2016 tombarr. All rights reserved.
//

import Foundation

class CreditApplicationDetailViewController: UIViewController, CreditApplicationPendingDelegate, CreditApplicationApprovedDelegate {
    
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
    
    @IBAction func won(sender: AnyObject) {
        creditApplication["hitBonusAt"] = NSDate()
        creditApplication.saveEventually()
        // move to cancelation
    }
    @IBAction func lost(sender: AnyObject) {
        creditApplication["missedBonusAt"] = NSDate()
        creditApplication.saveEventually()
        // move to cancelation
    }
    @IBAction func canceled(sender: AnyObject) {
        creditApplication["canceledAt"] = NSDate()
        creditApplication.saveEventually()
        // move to end state
    }
    
    func setCorrectView() {
    }
    
    override func viewDidLoad() {
        title = creditApplication.offer?.name
        self.setCorrectView()
    }
}