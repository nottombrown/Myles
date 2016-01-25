//
//  CreditApplicationDeclined.swift
//  Myles
//
//  Created by Finbarr Taylor on 1/25/16.
//  Copyright © 2016 tombarr. All rights reserved.
//

import Foundation

protocol CreditApplicationDeclinedDelegate {
    func creditApplicationReapplied()
}

class CreditApplicationDeclined: UIView {
    var delegate:CreditApplicationDeclinedDelegate?
    let creditApplication:CreditApplication
    
    init(creditApplication:CreditApplication) {
        self.creditApplication = creditApplication
        super.init(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @IBAction func reapply(sender: AnyObject) {
        self.delegate?.creditApplicationReapplied()
    }
}