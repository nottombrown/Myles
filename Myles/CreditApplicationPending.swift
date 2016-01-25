//
//  CreditApplicationPending.swift
//  Myles
//
//  Created by Finbarr Taylor on 1/25/16.
//  Copyright © 2016 tombarr. All rights reserved.
//

import Foundation

protocol CreditApplicationPendingDelegate {
    func creditApplicationApproved()
    func creditApplicationDeclined()
}

class CreditApplicationPending: UIView {
    var delegate:CreditApplicationPendingDelegate?
    var creditApplication:CreditApplication?
    
    @IBAction func approved(sender: AnyObject) {
        delegate?.creditApplicationApproved()
    }
    @IBAction func declined(sender: AnyObject) {
        delegate?.creditApplicationDeclined()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        print("awaking pending")
    }
}