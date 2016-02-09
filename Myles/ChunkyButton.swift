//
//  ChunkyButtonView.swift
//  Myles
//
//  Created by Tom Brown on 2/9/16.
//  Copyright © 2016 tombarr. All rights reserved.
//

import UIKit

class ChunkyButton: SimpleButton {

    override func configureButtonStyles() {
        super.configureButtonStyles()
        setBorderWidth(1.0, forState: .Normal)
        setBackgroundColor(highlightColor, forState: .Normal)

        setBackgroundColor(highlightColor.colorWithAlphaComponent(0.9), forState: .Highlighted)
        setBorderColor(highlightColor, forState: .Normal)

        setTitleColor(UIColor.whiteColor(), forState: .Normal)
        setCornerRadius(2.0)
    }
}
