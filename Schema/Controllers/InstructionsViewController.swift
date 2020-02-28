//
//  InstructionsViewController.swift
//  Schema
//
//  Created by itay gervash on 23/02/2020.
//  Copyright © 2020 Lazy Bear Apps. All rights reserved.
//

import UIKit

class InstructionsViewController: BetterUIViewController {

    @IBOutlet weak var instructions: UILabel!
    
    var numOfQuestions: Int = 90
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.applyGradientColorToBackGround(color1: K.Colours.blue, color2: K.Colours.green)
        
        if UserDefaults.standard.bool(forKey: "short_quiz") {
            numOfQuestions = 18
        }
        instructions.text = "You will be presented with \(numOfQuestions) statements. Select how much you agree with each statement from the options given. "
    }
    
    @IBAction func beginButtonPressed(_ sender: UIButton) {
        if UserDefaults.standard.bool(forKey: "auto_save") {
            performSegue(withIdentifier: "instructionsToName", sender: self)
        } else {
            performSegue(withIdentifier: "instructionsToQuiz", sender: self)
        }
    }
    
}
