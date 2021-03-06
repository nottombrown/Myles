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
    var creditApplication:CreditApplication?
    
    @IBOutlet weak var declinedInstructionLabel: UILabel!
    @IBOutlet weak var reapplyInstructionLabel: UILabel!
    @IBAction func reapply(sender: AnyObject) {
        self.delegate?.creditApplicationReapplied()
    }
}