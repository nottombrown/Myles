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
    var creditApplication:CreditApplication?
    var delegate:CreditApplicationDeliveredDelegate?
    
    @IBAction func win(sender: AnyObject) {
        self.delegate?.creditApplicationBonusHit()
    }
    @IBAction func lose(sender: AnyObject) {
        self.delegate?.creditApplicationBonusMissed()
    }
}