//
//  TableViewHeightTrait.swift
//  Myles
//
//  Created by Tom Brown on 1/20/16.
//  Copyright © 2016 tombarr. All rights reserved.
//

import Foundation
import Parse

// Shared functionality across all table view controllers
class MylesTableViewController: PFQueryTableViewController {

    override func viewWillAppear(animated: Bool) {
        loadObjects()
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 75.0
    }
}