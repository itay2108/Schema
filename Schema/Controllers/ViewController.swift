//
//  ViewController.swift
//  YSQ
//
//  Created by Itay Garbash on 01/02/2020.
//  Copyright © 2020 Lazy Bear Apps. All rights reserved.
//

import UIKit
import MessageUI

class ViewController: BetterUIViewController {

    @IBOutlet var buttons: [UIButton]!
    @IBOutlet weak var beginButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.

        view.applyGradientColorToBackGround(color1: K.Colours.blue, color2: K.Colours.green)
        
        
        print(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask))
        
        if UIApplication.isFirstLaunch() {
            print("First launch")
            UserDefaults.standard.set(false, forKey: "isSavedProgressAvailable") 
            UserDefaults.standard.set(0, forKey: "currentQuestion")
        }
        for button in self.buttons {
            button.setBackgroundColor(UIColor(displayP3Red: 0, green: 0, blue: 0, alpha: 0.1), forState: .highlighted)
        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        SettingsBundleHandler.shared.delegate = self
        SettingsBundleHandler.shared.setupNotificationObserver()
        
        if UserDefaults.standard.bool(forKey: "isSavedProgressAvailable") {
            beginButton.setTitle("  Continue Questionnaire", for: UIControl.State.normal)
        } else {
            beginButton.setTitle("  Begin Questionnaire", for: UIControl.State.normal)
        }
        
        

    }

// MARK: - @IBActions for buttons
    
    @IBAction func beginButtonPressed(_ sender: UIButton) {
        
        if UIApplication.isFirstLaunch() {
            performSegue(withIdentifier: "rootToInstructions", sender: self)
        } else {
            if UserDefaults.standard.bool(forKey: "auto_save") && !UserDefaults.standard.bool(forKey: "isSavedProgressAvailable") {
                print("autosave is active. progress not available")
                performSegue(withIdentifier: "rootToName", sender: self)
            } else {
                print("not autosave, and/or progress is available")
                performSegue(withIdentifier: "rootToQuiz", sender: self)
              }
        }
    }
    
    @IBAction func showCopyRight(_ sender: UIButton) {
        let alert = UIAlertController(title: nil, message: "This app was developed for educational purposes only. If you are the owner of any of the intellectual property used in this app, and would like it to be taken down - please contact the developer", preferredStyle: .actionSheet)
        
        let cancelBtn = UIAlertAction(title: "Cancel", style: .cancel) { (UIAlertAction) in
        }
        
        let contactBtn = UIAlertAction(title: "Contact Developer", style: .destructive) { (action) in
            self.showMailComposer()
        }
        
        alert.addAction(cancelBtn)
        alert.addAction(contactBtn)
        
        present(alert, animated: true)
    }
    
    func showMailComposer() {
        guard MFMailComposeViewController.canSendMail() else { /*show alert informing the user he cant send mails*/ return }
        
        let composer = MFMailComposeViewController()
        composer.mailComposeDelegate = self
        composer.setToRecipients(["gervash@icloud.com"])
        composer.setSubject("Copyright violation (Schema app)")
        
        present(composer, animated: true)
    }
    
    @IBAction func settingsButtonPressed(_ sender: UIButton) {
        guard let settingsUrl = URL(string: UIApplication.openSettingsURLString) else {
             return
         }

         if UIApplication.shared.canOpenURL(settingsUrl) {
             UIApplication.shared.open(settingsUrl, completionHandler: { (success) in
                 print("Settings opened: \(success)") // Prints true
             })
         }
    }
}

// MARK: - Extension for MFMailCompose Delegate

extension ViewController: MFMailComposeViewControllerDelegate {
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        
        let alert = UIAlertController(title: "Message sent", message: "The developer will be in touch shortly", preferredStyle: .alert)
        
        let dismiss = UIAlertAction(title: "Dismiss", style: .cancel) { (UIAlertAction) in
        }
        
        alert.addAction(dismiss)
        
        
        if let safeError = error {
            //show error alert
            print(safeError)
            controller.dismiss(animated: true)
            return
        }
        
        controller.dismiss(animated: true)
        
        switch result {
        case .sent:
            present(alert, animated: true)
        default:
            print("hello, World!")
        }

    }
    
}
