//
//  OfferTableViewCell.swift
//  Myles
//
//  Created by Tom Brown on 1/20/16.
//  Copyright © 2016 tombarr. All rights reserved.
//

import Foundation
import Parse

class OfferTableViewCell: PFTableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var cardImage: PFImageView!
    @IBOutlet weak var rewardLabel: UILabel!
}