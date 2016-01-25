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
    let creditApplication:CreditApplication
    var delegate:CreditApplicationLiveDelegate?
    
    init(creditApplication:CreditApplication) {
        self.creditApplication = creditApplication
        super.init(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
    }
    
    @IBAction func canceled(sender: AnyObject) {
        self.delegate?.creditApplicationCanceled()
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}