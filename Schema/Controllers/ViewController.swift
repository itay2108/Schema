//
//  ViewController.swift
//  YSQ
//
//  Created by Itay Garbash on 01/02/2020.
//  Copyright © 2020 Lazy Bear Apps. All rights reserved.
//

import UIKit
import MessageUI
import StoreKit

class ViewController: BetterUIViewController {

    @IBOutlet var buttons: [UIButton]!
    @IBOutlet weak var beginButton: UIButton!
    @IBOutlet weak var savedResultsButton: UIButton!
    
    
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
        //setting ViewController as the observer for paymentQueue
        SKPaymentQueue.default().add(self)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        UserDefaults.standard.set(true, forKey: "pro_version")
        if UserDefaults.standard.bool(forKey: "pro_version") {
            savedResultsButton.setBackgroundImage(UIImage(named: "Saved Results Button"), for: .normal)
        } else {
            savedResultsButton.setBackgroundImage(UIImage(named: "Saved Results Pro"), for: .normal)
        }
        
        SettingsBundleHandler.shared.delegate = self
        SettingsBundleHandler.shared.setupNotificationObserver()
        
        if UserDefaults.standard.bool(forKey: "isSavedProgressAvailable") {
            beginButton.setBackgroundImage(UIImage(named: "Continue Button"), for: .normal)
        } else {
            beginButton.setBackgroundImage(UIImage(named: "Begin Button"), for: .normal)
            
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
    
    @IBAction func savedResultsButtonPressed(_ sender: UIButton) {
        if UserDefaults.standard.bool(forKey: "pro_version") {
            performSegue(withIdentifier: "rootToSavedResults", sender: self)
        } else {
            //upgradeToPro()
            performSegue(withIdentifier: "popOver", sender: self)
            
            
        }
        
    }
    
    
    @IBAction func shareButtonPressed(_ sender: UIButton) {
        let firstActivityItem = "I've been using the Schema Therapy app, and its pretty great!"
        //link
        //let secondActivityItem : NSURL = NSURL(string: "http//:urlyouwant")!
        //image
        //let image : UIImage = UIImage(named: "image.jpg")!

        let activityViewController : UIActivityViewController = UIActivityViewController(
            activityItems: [firstActivityItem], applicationActivities: nil)

        // This lines is for the popover you need to show in iPad
        activityViewController.popoverPresentationController?.sourceView = (sender)

        // This line remove the arrow of the popover to show in iPad
        activityViewController.popoverPresentationController?.permittedArrowDirections = UIPopoverArrowDirection.any
        activityViewController.popoverPresentationController?.sourceRect = CGRect(x: 150, y: 150, width: 0, height: 0)

        // Anything you want to exclude
        activityViewController.excludedActivityTypes = [
            UIActivity.ActivityType.postToWeibo,
            UIActivity.ActivityType.print,
            UIActivity.ActivityType.assignToContact,
            UIActivity.ActivityType.saveToCameraRoll,
            UIActivity.ActivityType.addToReadingList,
            UIActivity.ActivityType.postToFlickr,
            UIActivity.ActivityType.postToVimeo,
            UIActivity.ActivityType.postToTencentWeibo
        ]

        self.present(activityViewController, animated: true, completion: nil)
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
    
    @IBAction func restoreButtonPressed(_ sender: UIButton) {
        SKPaymentQueue.default().restoreCompletedTransactions()
    }
    
    func upgradeToPro() {
        guard SKPaymentQueue.canMakePayments() else {
            print("can't make payments")
            return }
        
        let paymentResuest = SKMutablePayment()
        paymentResuest.productIdentifier = K.Strings.proVersionID
        SKPaymentQueue.default().add(paymentResuest)
        
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

extension ViewController: SKPaymentTransactionObserver {
    func paymentQueue(_ queue: SKPaymentQueue, updatedTransactions transactions: [SKPaymentTransaction]) {
        for transaction in transactions {
            if transaction.transactionState == .purchased {
                //purchased
                savedResultsButton.setBackgroundImage(UIImage(named: "Saved Results Button"), for: .normal)
                SKPaymentQueue.default().finishTransaction(transaction)
                
            } else if transaction.transactionState == .failed {
                   //failed
                if let safeError = transaction.error?.localizedDescription {
                    print("error completing purchase: \(safeError)")
                }
            } else if transaction.transactionState == .restored {
                //restored
                UserDefaults.standard.set(true, forKey: "pro_version")
                savedResultsButton.setBackgroundImage(UIImage(named: "Saved Results Button"), for: .normal)
                
                let alert = UIAlertController(title: "Restore Purchase", message: "Your purchase was restored successfuly. You now have the pro version of Schema", preferredStyle: .alert)
                let dismiss = UIAlertAction(title: "Dismiss", style: .default) { (action) in
                    SKPaymentQueue.default().finishTransaction(transaction)
                    alert.dismiss(animated: true)
                }
                alert.addAction(dismiss)
                present(alert, animated: true)
            }
        }
    }

}

