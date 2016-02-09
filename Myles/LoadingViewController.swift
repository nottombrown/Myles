//
//  LoadingViewController.swift
//  Myles
//
//  Created by Finbarr Taylor on 1/27/16.
//  Copyright © 2016 tombarr. All rights reserved.
//

import Foundation

class LoadingViewController: UIViewController {
    
    @IBOutlet weak var activityView: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.activityView.startAnimating()
    }
}