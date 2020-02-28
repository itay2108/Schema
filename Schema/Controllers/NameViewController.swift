//
//  NameViewController.swift
//  Schema
//
//  Created by itay gervash on 23/02/2020.
//  Copyright © 2020 Lazy Bear Apps. All rights reserved.
//

import UIKit

class NameViewController: BetterUIViewController, UITextFieldDelegate {

    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var placeHolder: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.applyGradientColorToBackGround(color1: K.Colours.blue, color2: K.Colours.green)
        
        self.nameTextField.delegate = self
        hideKeyboardWhenTappedAround()
        
        //listening for settings changes and hangling force dark theme
        SettingsBundleHandler.shared.delegate = self
        SettingsBundleHandler.shared.setupNotificationObserver()
        
        //setting textfield placeholder
        nameTextField.attributedPlaceholder = NSAttributedString(string: "Your Name",
        attributes: [NSAttributedString.Key.foregroundColor: UIColor(displayP3Red: 1, green: 1, blue: 1, alpha: 0.66)])
        placeHolder.fadeOut(duration: 0, delay: 0)
        
        //listening for text changes
        self.nameTextField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: UIControl.Event.editingChanged)
    }
    
    
//MARK: - TextField Delegate Methods
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        if nameTextField.text == "" {
           endWritingAnimation()
        } else {
            setNameAndPerformSegue()
        }
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        beginWritingAnimation()
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if nameTextField.text == "" {
           endWritingAnimation()
        }
        return true
    }
    
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        endWritingAnimation()
        return true
        
    }
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        if nameTextField.text == "" {
            endWritingAnimation()
        } else {
            beginWritingAnimation()
        }
    }
//MARK: - TextField Animation Methods
    
    func beginWritingAnimation() {
        placeHolder.fadeIn(duration: 0.15, delay: 0)
        nameTextField.attributedPlaceholder = NSAttributedString(string: "")
    }
    
    func endWritingAnimation() {
        placeHolder.fadeOut(duration: 0.15, delay: 0)
        nameTextField.attributedPlaceholder = NSAttributedString(string: "Your Name", attributes: [NSAttributedString.Key.foregroundColor : UIColor(displayP3Red: 1, green: 1, blue: 1, alpha: 0.5)])
    }
    
//MARK: - IBActions
    
    @IBAction func continueButtonPressed(_ sender: UIButton) {
        setNameAndPerformSegue()
    }
    
    func setNameAndPerformSegue() {
        guard nameTextField.text != "" else {
            return
        }
        
        if let safeName = nameTextField?.text {
            ResultsModel.shared.name = safeName
            performSegue(withIdentifier: "nameToQuiz", sender: self)
        }
    }
    
}


