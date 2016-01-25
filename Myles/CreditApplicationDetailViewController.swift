//
//  CreditApplicationDetailViewController.swift
//  Myles
//
//  Created by Tom Brown on 1/20/16.
//  Copyright © 2016 tombarr. All rights reserved.
//

import Foundation

class CreditApplicationDetailViewController: UIViewController {
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var approvedButton: UIButton!
    @IBOutlet weak var declinedButton: UIButton!
    @IBOutlet weak var deliveredButton: UIButton!
    @IBOutlet weak var winButton: UIButton!
    @IBOutlet weak var loseButton: UIButton!
    @IBOutlet weak var canceledButton: UIButton!
    
    let creditApplication: CreditApplication
    
    init(creditApplication: CreditApplication) {
        self.creditApplication = creditApplication
        super.init(nibName: nil, bundle: nil)
    }
    
    required init(coder: NSCoder) {
        // http://stackoverflow.com/questions/25126295/swift-class-does-not-implement-its-superclasss-required-members
        fatalError("NSCoding not supported")
    }
    
    @IBAction func approved(sender: AnyObject) {
        creditApplication["approvedAt"] = NSDate()
        creditApplication.saveEventually()
        // move to delivered
    }
    
    @IBAction func declined(sender: AnyObject) {
        creditApplication["declinedAt"] = NSDate()
        creditApplication.saveEventually()
        // move to initial
    }
    @IBAction func delivered(sender: AnyObject) {
        creditApplication["deliveredAt"] = NSDate()
        creditApplication.saveEventually()
        // move to bonus
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
    
    override func viewDidLoad() {
        title = creditApplication.offer?.name
        nameLabel.text = "\(creditApplication.offer?.name!) Details"
    }
}