//
//  InfoViewController.swift
//  YSQ
//
//  Created by Itay Garbash on 02/02/2020.
//  Copyright © 2020 Lazy Bear Apps. All rights reserved.
//

import UIKit

class InfoViewController: BetterUIViewController {

    @IBOutlet weak var schemeLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UITextView!
    
    var scheme: String = ""
    var schemeDescription: String = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        SettingsBundleHandler.shared.delegate = self
        SettingsBundleHandler.shared.setupNotificationObserver()
        
        
        schemeLabel.text = scheme
        descriptionLabel.text = schemeDescription
    }
    
    @IBAction func DismissButtonPressed(_ sender: UIButton) {
        self.dismiss(animated: true)
    }
    

}
