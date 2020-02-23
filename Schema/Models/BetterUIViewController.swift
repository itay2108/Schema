//
//  DarkUI.swift
//  Schema
//
//  Created by itay gervash on 21/02/2020.
//  Copyright © 2020 Lazy Bear Apps. All rights reserved.
//

import Foundation
import UIKit

class BetterUIViewController: UIViewController, UIStyle {

    
    func forceDarkUI(_ style: Bool) {
        switch style {
        case true:
        overrideUserInterfaceStyle = .dark
        default:
        overrideUserInterfaceStyle = .unspecified
        }
    }
    
    func hideKeyboardWhenTappedAround() {
        let tapGesture = UITapGestureRecognizer(target: self,
                         action: #selector(hideKeyboard))
        view.addGestureRecognizer(tapGesture)
    }

    @objc func hideKeyboard() {
        
        view.endEditing(true)
    }
    
}

//MARK: - Change UIButton Background Color when pressed

extension UIButton {
  func setBackgroundColor(_ color: UIColor, forState controlState: UIControl.State) {
    let colorImage = UIGraphicsImageRenderer(size: CGSize(width: 1, height: 1)).image { _ in
      color.setFill()
      UIBezierPath(rect: CGRect(x: 0, y: 0, width: 1, height: 1)).fill()
    }
    setBackgroundImage(colorImage, for: controlState)
  }
    
    
    @IBInspectable var adjustFontSizeToWidth: Bool {
        get {
            return self.titleLabel!.adjustsFontSizeToFitWidth
        }
        set {
            self.titleLabel?.numberOfLines = 1
            self.titleLabel?.adjustsFontSizeToFitWidth = newValue;
            self.titleLabel?.lineBreakMode = .byClipping;
            self.titleLabel?.baselineAdjustment = .alignCenters
            self.contentEdgeInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        }
    }
}

extension UIView {

    func fadeIn(duration: TimeInterval, delay: TimeInterval, completion: @escaping ((Bool) -> Void) = {(finished: Bool) -> Void in}) {
        UIView.animate(withDuration: duration, delay: delay, options: UIView.AnimationOptions.curveEaseIn, animations: {
        self.alpha = 1.0
        }, completion: completion)  }

    func fadeOut(duration: TimeInterval, delay: TimeInterval, completion: @escaping (Bool) -> Void = {(finished: Bool) -> Void in}) {
        UIView.animate(withDuration: duration, delay: delay, options: UIView.AnimationOptions.curveEaseIn, animations: {
        self.alpha = 0.0
        }, completion: completion)
}

}
