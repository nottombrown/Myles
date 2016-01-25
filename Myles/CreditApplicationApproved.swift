//
//  CreditApplicationApproved.swift
//  Myles
//
//  Created by Finbarr Taylor on 1/25/16.
//  Copyright © 2016 tombarr. All rights reserved.
//

import Foundation

protocol CreditApplicationApprovedDelegate {
    func creditApplicationDelivered()
}

class CreditApplicationApproved: UIView {
    var creditApplication:CreditApplication?
    var delegate:CreditApplicationApprovedDelegate?

    @IBAction func delivered(sender: AnyObject) {
        self.delegate?.creditApplicationDelivered()
    }
}
