//
//  ResultsViewController.swift
//  YSQ
//
//  Created by Itay Garbash on 02/02/2020.
//  Copyright © 2020 Lazy Bear Apps. All rights reserved.
//

import UIKit
import RealmSwift

class ResultsViewController: BetterUIViewController {
    
    
    @IBOutlet var saveBarButtonItem: UIBarButtonItem!
    @IBOutlet weak var tableView: UITableView!
    
    let info = Info()
    let resultCell = ResultCell()
    let savedResult = SavedResult()
    let realm = try! Realm()
    let dateFormatter = DateFormatter()
    
    var results: Results<ResultsModel>?
    var pastResults: List<Int>?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.applyGradientColorToBackGround(color1: K.Colours.blue, color2: K.Colours.green)
        
        SettingsBundleHandler.shared.delegate = self
        SettingsBundleHandler.shared.setupNotificationObserver()
        
        
        //populating results var with realm results (saved while answering questions)
        fetchFromrealm()
        
        //checking that the previous vc is not PastResultsVC, then removing quizViewController from navigation stack, so when the back button is pressed - it opens the root vc
       if pastResults == nil {
            if let rootVC = navigationController?.viewControllers.first {
                navigationController?.viewControllers = [rootVC, self]
            }
        }

            
        
        //If past results isn't nil, it is only because it was set by the PastResultsVC, so it must be showing a saved result. *OR* if autosave is on so it is automatically saved
        //This is why the save button need to be "toggled"
        if pastResults != nil || UserDefaults.standard.bool(forKey: "auto_save") {
            saveBarButtonItem.isEnabled = false
            saveBarButtonItem.title = "Saved"
        }

    }
    
    override func viewDidDisappear(_ animated: Bool) {
        //resestting past results when closing screen
        pastResults = nil
    }
    
    @IBAction func saveButtonPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        textField.autocapitalizationType = .words
        
        let alert = UIAlertController(title: "Save your results", message: "Input your name", preferredStyle: .alert)
        
        let saveBtn = UIAlertAction(title: "Save", style: .default) { (action) in
            
            if let safeResultArray = self.results?.last?.resultArray {
                for i in safeResultArray {
                    self.savedResult.result.append(i)
                }
                print(self.savedResult.result)
            }
            
            if let safeText = textField.text {
                self.savedResult.name = safeText
            }
            
            do {
                try self.realm.write {
                    if self.savedResult.name != "" {
                        self.savedResult.date = Date()
                        self.realm.add(self.savedResult)
                    }
                }
                sender.title = "Saved"
                sender.isEnabled = false
                
            } catch {
                print("error saving result to realm \(error)")
            }
        }
        
        let cancelBtn = UIAlertAction(title: "Cancel", style: .cancel) { (UIAlertAction) in
        }
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Enter your name"
            textField = alertTextField
        }
        
        alert.addAction(saveBtn)
        alert.addAction(cancelBtn)
        
        self.present(alert, animated: true)
        
        
        
    }
    
    @IBAction func backButtonPressed(_ sender: UIBarButtonItem) {
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    func fetchFromrealm() {
        results = realm.objects(ResultsModel.self)
    }

    
}

extension ResultsViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return results?[0].resultArray.count ?? 1
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "resultCell") as! ResultCell
        
        //if past results was set from saved results screen - create a Results model instance with saved result as the result array, then use this instance to populate the cells.
        if pastResults != nil {
            let resultModel = ResultsModel()
            resultModel.resultArray = pastResults!
            cell.setData(with: resultModel, indexPath: indexPath, info: info)
        } else {
        //if past results is nil, it means that this viewcontroller was loaded from the quizViewController, and we will use the results var which was loaded from Realm to set the cell data.
            if let result = results?.last {
                cell.setData(with: result, indexPath: indexPath, info: info)
            }
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        performSegue(withIdentifier: "resultsToInfo", sender: self)
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destination = segue.destination as! InfoViewController
        if let indexPath = tableView.indexPathForSelectedRow {
            destination.scheme = info.titles[indexPath.row]
            destination.schemeDescription = info.schemeDescriptions[indexPath.row]
        }
    }
}


