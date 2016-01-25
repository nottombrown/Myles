//
//  CreditApplicationCanceled.swift
//  Myles
//
//  Created by Finbarr Taylor on 1/25/16.
//  Copyright © 2016 tombarr. All rights reserved.
//

import Foundation

class CreditApplicationCanceled: UIView {
    let creditApplication:CreditApplication
    
    init(creditApplication:CreditApplication) {
        self.creditApplication = creditApplication
        super.init(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}