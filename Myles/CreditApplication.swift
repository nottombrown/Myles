//
//  CreditApplication.swift
//  Myles
//
//  Created by Finbarr Taylor on 1/20/16.
//  Copyright © 2016 tombarr. All rights reserved.
//

import Foundation

class CreditApplication: PFObject {
}


extension CreditApplication: PFSubclassing {
    @NSManaged var image: PFFile
    @NSManaged var name: String?
    @NSManaged var reward: String?
    
    // Table view delegate methods here
    //1
    class func parseClassName() -> String {
        return "CreditApplication"
    }
    
    //2
    
    override class func initialize() {
        var onceToken: dispatch_once_t = 0
        dispatch_once(&onceToken) {
            self.registerSubclass()
        }
    }
}


