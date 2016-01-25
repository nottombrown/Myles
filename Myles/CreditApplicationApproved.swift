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
    let creditApplication:CreditApplication
    var delegate:CreditApplicationApprovedDelegate?
    
    init(creditApplication:CreditApplication) {
        self.creditApplication = creditApplication
        super.init(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
    }

    @IBAction func delivered(sender: AnyObject) {
        self.delegate?.creditApplicationDelivered()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
