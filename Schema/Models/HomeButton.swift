//
//  HomeButton.swift
//  Schema
//
//  Created by itay gervash on 28/02/2020.
//  Copyright © 2020 Lazy Bear Apps. All rights reserved.
//

import UIKit

class HomeButton: UIButton {

    @IBOutlet weak var buttonBackground: UIView!
    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var title: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    
    func setup() {
        setShadow()
        
        setTitleColor(.label, for: .normal)
        backgroundColor = UIColor(named: "YSQ-BG")
        tintColor = .systemBlue
        //setTitleColor(K.Colours.darkGray, for: .normal)
        //backgroundColor = .white
        //titleLabel?.font = UIFont(name: "AvenirNext-DemiBold", size: 16.0)
        layer.cornerRadius = 20
        
    }
    
    private func setShadow() {
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = CGSize(width: 0.0, height: 6.0)
        layer.shadowRadius = 8
        layer.shadowOpacity = 0.33
        clipsToBounds = true
    }
}

class UpgradeButton: HomeButton {
    override func setup() {
        super.setup()
        backgroundColor = K.Colours.blue
        setTitleColor(.white, for: .normal)
        layer.cornerRadius = 7.5
    }
}
