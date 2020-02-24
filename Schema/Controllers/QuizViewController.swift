//
//  QuizViewController.swift
//  YSQ
//
//  Created by Itay Garbash on 01/02/2020.
//  Copyright © 2020 Lazy Bear Apps. All rights reserved.
//

import UIKit
import RealmSwift

class QuizViewController: BetterUIViewController {
    
    @IBOutlet var buttons: [UIButton]!
    @IBOutlet var nextButton: UIButton!
    
    @IBOutlet weak var questionLabel: UILabel!
    
    var resultsModel = ResultsModel()
    let savedResult = SavedResult()
    let realm = try! Realm()
    let defaults = UserDefaults.standard
    var results: Results<ResultsModel>?
    
    var selectedScore: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //If there isn't a questionnaire in progress - Delete old results and create a blank List<Int> with 18 places that are equal to 0. else - keep the result array in progress
        if !defaults.bool(forKey: "isSavedProgressAvailable") {
            if !UIApplication.isFirstLaunch() {
                try! realm.write {
                    realm.delete(realm.objects(ResultsModel.self))
                }
            }
            createEmptyResultsArray()
        } else {
            results = realm.objects(ResultsModel.self)
            try! realm.write {
                resultsModel.resultArray = (results?.last!.resultArray)!
            }
            QuestionModel.shared.currentQuestion = defaults.integer(forKey: "currentQuestion")
        }
        
        SettingsBundleHandler.shared.delegate = self
        SettingsBundleHandler.shared.setupNotificationObserver()
        updateUI()
        
        //Removing Instructions ViewController from navigation stack, so when the back button is pressed - it opens the root vc
        if let rootVC = navigationController?.viewControllers.first {
            navigationController?.viewControllers = [rootVC, self]
        }
        
        nextButton.setBackgroundColor(UIColor(displayP3Red: 0, green: 0, blue: 0, alpha: 0.1), forState: .highlighted)
        
        for button in self.buttons {
            button.setBackgroundColor(UIColor(displayP3Red: 0, green: 0, blue: 0, alpha: 0.1), forState: .highlighted)
            button.titleLabel?.minimumScaleFactor = 0.01
            button.titleLabel?.adjustsFontSizeToFitWidth = true
        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        updateUI()
    }
    
    
    // MARK: - @IBOutlet funcs
    
    
    @IBAction func answerPressed(_ sender: UIButton) {
        
        deselectAllAnswerButtons()
        
        selectedScore = sender.tag
        sender.setImage(UIImage(systemName: "circle.fill"), for: .normal)
        sender.titleLabel?.font = UIFont(name: "AvenirNext-Bold", size: 21.0)
    }
    
    @IBAction func nextButtonPressed(_ sender: UIButton) {
        
        //checking that it is not the last question
        if (QuestionModel.shared.currentQuestion + 1) < QuestionModel.shared.questions.count {
            
            //checking that answer is selected
            if selectedScore != nil {
                
                //button vibration feedback
                Vibration.medium.vibrate()
                // deselecting all previously selected answer buttons
                deselectAllAnswerButtons()
                
                //safely unwarpping selected score and current scheme score
                if let safeScore = selectedScore {
                    do {
                        try realm.write {
                            resultsModel.resultArray[(QuestionModel.shared.currentQuestion % 18)] += safeScore
                        }
                    } catch {
                        print(error)
                    }
                    
                    //moving one question forward and updating all text
                    QuestionModel.shared.currentQuestion += 1
                    questionLabel.fadeOut(duration: 0.15, delay: 0)
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(150)) {
                        self.updateUI()
                        self.questionLabel.fadeIn(duration: 0.15, delay: 0)
                    }
                    
                }
            }
        } else {
            //this is what happens when next is pressed on last question
            
            if let safeScore = selectedScore {
                do {
                    try realm.write {
                        resultsModel.resultArray[(QuestionModel.shared.currentQuestion % 18)] += safeScore
                    }
                } catch {
                    print(error)
                }
            }
            
            
            if defaults.bool(forKey: "auto_save") {
                autoSave()
            }
            
            QuestionModel.shared.currentQuestion = 0
            self.defaults.set(false, forKey: "isSavedProgressAvailable")
            performSegue(withIdentifier: "quizToResults", sender: self)
        }
    }
    
    //MARK: - UI Manipulation funcs
    
    func updateUI() {
        
        navigationItem.title = "Question \(QuestionModel.shared.currentQuestion + 1)/\(QuestionModel.shared.questions.count)"
        questionLabel.text = "\(QuestionModel.shared.questions[(QuestionModel.shared.currentQuestion)])"
        selectedScore = nil
        
        
    }
    
    func deselectAllAnswerButtons() {
        
        for button in self.buttons {
            button.setImage(UIImage(systemName: "circle"), for: .normal)
            button.titleLabel?.font = UIFont(name: "AvenirNext-DemiBold", size: 21.0)
        }
        
    }
    
    func createEmptyResultsArray() {
        for _ in 1...18 {
            resultsModel.resultArray.append(0)
        }
        
        do{
            try realm.write {
                realm.add(resultsModel)
                
            }
        } catch {
            print("error adding results array to realm \(error)")
        }
    }
    
    //MARK: - Back button logic (Includes pregress saving and discrading)
    
    @IBAction func backButtonPressed(_ sender: UIBarButtonItem) {
        
        if QuestionModel.shared.currentQuestion != 0 {
            let alert = UIAlertController(title: "Are you sure you want to quit?", message: "Your progress will be discarded", preferredStyle: .alert)
            
            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (action) in
            }
            
            let saveAndQuitAction = UIAlertAction(title: "Save and quit", style: .default) { (action) in
                
                self.defaults.set(QuestionModel.shared.currentQuestion, forKey: "currentQuestion")
                self.defaults.set(true, forKey: "isSavedProgressAvailable")
                
                self.navigationController?.popViewController(animated: true)
                
            }
            
            let discardAction = UIAlertAction(title: "Quit without saving", style: .destructive) { (action) in
                
                self.defaults.set(false, forKey: "isSavedProgressAvailable")
                
                QuestionModel.shared.currentQuestion = 0
                self.navigationController?.popViewController(animated: true)
            }
            
            alert.addAction(saveAndQuitAction)
            alert.addAction(discardAction)
            alert.addAction(cancelAction)
            
            self.present(alert, animated: true)
        } else {   self.navigationController?.popViewController(animated: true)    }
    }
    
    //MARK: - handle autosave
    
    func autoSave() {
        
        for i in self.resultsModel.resultArray {
            self.savedResult.result.append(i)
        }
        
        do {
            try self.realm.write {
                self.savedResult.name = ResultsModel.shared.name
                self.savedResult.date = Date()
                self.realm.add(self.savedResult)
                print("success saving result: ")
                print(self.savedResult)
            }
        } catch {
            print("error saving result to realm \(error)")
        }
    }
    
}
    


