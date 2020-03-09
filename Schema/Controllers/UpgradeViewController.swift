//
//  UpgradeViewController.swift
//  Schema
//
//  Created by itay gervash on 01/03/2020.
//  Copyright © 2020 Lazy Bear Apps. All rights reserved.
//

import UIKit
import StoreKit

class UpgradeViewController: UIViewController {

    @IBOutlet weak var upgradeButton: UpgradeButton!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    
    var products = [SKProduct]()
    var request: SKProductsRequest!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        upgradeButton.setTitle("", for: .normal)
        // Do any additional setup after loading the view.
        SKPaymentQueue.default().add(self)
        activityIndicator.center = upgradeButton.center
        activityIndicator.hidesWhenStopped = true
        activityIndicator.style = .medium
        activityIndicator.startAnimating()
        
        validate(productIdentifiers: [K.Strings.proVersionID])
        
        
    }
    
    
    @IBAction func upgradeButtonPressed(_ sender: UIButton) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            sender.setTitle("", for: .normal)
            self.activityIndicator.startAnimating()
        }
        upgradeToPro()
        
    }
    
    
    func validate(productIdentifiers: [String]) {
        let productIdentifiers = Set(productIdentifiers)
        
        request = SKProductsRequest(productIdentifiers: productIdentifiers)
        request.delegate = self
        request.start()
    }
    
    
    func upgradeToPro() {
        guard SKPaymentQueue.canMakePayments() else {
            print("can't make payments")
            return }
        
        
        let paymentResuest = SKMutablePayment()
        paymentResuest.productIdentifier = K.Strings.proVersionID
        SKPaymentQueue.default().add(paymentResuest)
        
        
        
        
    }
    @IBAction func closeVC(_ sender: Any) {
        
        self.dismiss(animated: true)
    }
}

extension UpgradeViewController: SKPaymentTransactionObserver {
    func paymentQueue(_ queue: SKPaymentQueue, updatedTransactions transactions: [SKPaymentTransaction]) {
        for transaction in transactions {
            if transaction.transactionState == .purchased {
                //purchased
                SKPaymentQueue.default().finishTransaction(transaction)
                UserDefaults.standard.set(true, forKey: "pro_version")
                activityIndicator.stopAnimating()
                upgradeButton.setTitle("Success!", for: .normal)
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.15) {
                    self.dismiss(animated: true)
                }
                
            } else if transaction.transactionState == .failed {
                //failed
                if let safeError = transaction.error?.localizedDescription {
                    activityIndicator.stopAnimating()
                    upgradeButton.setTitle("Error", for: .normal)
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1.15) {
                        self.dismiss(animated: true)
                        
                        let errorAlert = UIAlertController(title: "There was an error precessing your purchase", message: "\(safeError)", preferredStyle: .alert)
                        let action = UIAlertAction(title: "Dismiss", style: .cancel) { (action) in
                        }
                        
                        errorAlert.addAction(action)
                        self.present(errorAlert, animated: true)
                    }
                }
            }
        }
        
    }
}

extension UpgradeViewController: SKProductsRequestDelegate {
    func productsRequest(_ request: SKProductsRequest, didReceive response: SKProductsResponse) {
        if !response.products.isEmpty {
           products = response.products
            if let localPrice = products.first?.localizedPrice {
                
                DispatchQueue.main.async {
                    
                    self.upgradeButton.setTitle("Upgrade for \(localPrice)", for: .normal)
                    
                }
                DispatchQueue.main.async {
                    
                    self.activityIndicator.stopAnimating()
                }
                
            }
           
        }

        for invalidIdentifier in response.invalidProductIdentifiers {
           // Handle any invalid product identifiers as appropriate.
            print("invalid product identifier: \(invalidIdentifier)")
        }
    }
}



extension SKProduct {
    fileprivate static var formatter: NumberFormatter {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        return formatter
    }

    var localizedPrice: String {
        if self.price == 0.00 {
            return "Get"
        } else {
            let formatter = SKProduct.formatter
            formatter.locale = self.priceLocale

            guard let formattedPrice = formatter.string(from: self.price) else {
                return "Unknown Price"
            }

            return formattedPrice
        }
    }
}
