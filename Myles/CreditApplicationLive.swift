//
//  CreditApplicationLive.swift
//  Myles
//
//  Created by Finbarr Taylor on 1/25/16.
//  Copyright © 2016 tombarr. All rights reserved.
//

import Foundation

protocol CreditApplicationLiveDelegate {
    func creditApplicationCanceled()
}

class CreditApplicationLive: UIView {
    var creditApplication:CreditApplication?
    var delegate:CreditApplicationLiveDelegate?
    
    @IBOutlet weak var cancelInstructionLabel: UILabel!
    @IBAction func canceled(sender: AnyObject) {
        self.delegate?.creditApplicationCanceled()
    }
}