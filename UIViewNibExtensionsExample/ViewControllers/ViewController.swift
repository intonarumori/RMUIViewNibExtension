//
//  ViewController.swift
//  XibHelpers
//
//  Created by Daniel Langh on 24/03/16.
//  Copyright © 2016 rumori. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let customView = SameNameView.instantiateFromNib() {
            customView.frame = CGRect(x: 100, y: 100, width: 100, height: 100)
            self.view.addSubview(customView)
        }

        if let customView = DifferentNameView.instantiateFromNib() {
            customView.frame = CGRect(x: 100, y: 200, width: 100, height: 100)
            self.view.addSubview(customView)
        }

        if let customView = MissingXibView.instantiateFromNib(nil, options:nil) {
            customView.frame = CGRect(x: 100, y: 300, width: 100, height: 100)
            self.view.addSubview(customView)
        }

        if let customView = MismatchingTypeXibView.instantiateFromNib() {
            customView.frame = CGRect(x: 100, y: 400, width: 100, height: 100)
            self.view.addSubview(customView)
        }
    }
}

