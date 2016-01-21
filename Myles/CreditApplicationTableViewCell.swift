//
//  CreditApplicationTableViewCell.swift
//  Myles
//
//  Created by Finbarr Taylor on 1/20/16.
//  Copyright © 2016 tombarr. All rights reserved.
//

import Foundation
import Parse

class CreditApplicationTableViewCell: PFTableViewCell {

    @IBOutlet weak var appliedAtLabel: UILabel!
    @IBOutlet weak var rewardLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var cardImage: PFImageView!
}
