//
//  CreditApplicationDelivered.swift
//  Myles
//
//  Created by Finbarr Taylor on 1/25/16.
//  Copyright © 2016 tombarr. All rights reserved.
//

import Foundation

protocol CreditApplicationDeliveredDelegate {
    func creditApplicationBonusHit()
    func creditApplicationBonusMissed()
}

class CreditApplicationDelivered: UIView {
    let creditApplication:CreditApplication
    var delegate:CreditApplicationDeliveredDelegate?
    
    init(creditApplication:CreditApplication) {
        self.creditApplication = creditApplication
        super.init(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @IBAction func win(sender: AnyObject) {
        self.delegate?.creditApplicationBonusHit()
    }
    @IBAction func lose(sender: AnyObject) {
        self.delegate?.creditApplicationBonusMissed()
    }
}