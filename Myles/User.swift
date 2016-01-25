//
//  User.swift
//  Myles
//
//  Created by Finbarr Taylor on 1/25/16.
//  Copyright © 2016 tombarr. All rights reserved.
//

import Foundation

class User {
    class func uuid() -> String! {
        let defaults = NSUserDefaults.standardUserDefaults()
        var uuid = defaults.stringForKey("uuid")
        if uuid == nil {
            uuid = NSUUID().UUIDString
            defaults.setObject(uuid, forKey: "uuid")
            defaults.synchronize()
        }
        return uuid!
    }
}
