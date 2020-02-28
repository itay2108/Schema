//
//  BetterUINavigationController.swift
//  Schema
//
//  Created by itay gervash on 27/02/2020.
//  Copyright © 2020 Lazy Bear Apps. All rights reserved.
//

import UIKit

class BetterUINavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
    }
    
}
