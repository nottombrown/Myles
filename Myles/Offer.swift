//
//  Offer.swift
//  Myles
//
//  Created by Tom Brown on 1/20/16.
//  Copyright © 2016 tombarr. All rights reserved.
//

import Foundation

class Offer: PFObject {
}


extension Offer: PFSubclassing {
    @NSManaged var image: PFFile
    @NSManaged var name: String?
    @NSManaged var reward: String?
    @NSManaged var condition: String?
    
    // Table view delegate methods here
    //1
    class func parseClassName() -> String {
        return "Offer"
    }
    
    //2
    
    override class func initialize() {
        var onceToken: dispatch_once_t = 0
        dispatch_once(&onceToken) {
            self.registerSubclass()
        }
    }
}


