//
//  SettingsBundleHandler.swift
//  Schema
//
//  Created by itay gervash on 20/02/2020.
//  Copyright © 2020 Lazy Bear Apps. All rights reserved.
//

import Foundation
import RealmSwift


protocol UIStyle {
    func forceDarkUI(_ style: Bool)
}

public class SettingsBundleHandler {
    
    public static let shared = SettingsBundleHandler()
    
    public struct SettingsBundleKeys {
        static let ForceDarkTheme = "force_dark"
        static let AutoSave = "auto_save"
        static let ShortQuiz = "short_quiz"
    }
    
    // MARK: - Handle settingBundle funcs
    
    var delegate: UIStyle?
//    var autoSaveDelegate: AutoSave?
    
    func registerSettingsBundle(){
         let defaults = [String:AnyObject]()
         UserDefaults.standard.register(defaults: defaults)
     }
    @objc func defaultsChanged(){
        
        if UserDefaults.standard.bool(forKey: "force_dark") {
            delegate?.forceDarkUI(UserDefaults.standard.bool(forKey: "force_dark"))
        } else {
            delegate?.forceDarkUI(UserDefaults.standard.bool(forKey: "force_dark"))
        }
        

     }
    
    public func setupNotificationObserver() {
        registerSettingsBundle()
        NotificationCenter.default.addObserver(self, selector: #selector(SettingsBundleHandler.shared.defaultsChanged), name: UserDefaults.didChangeNotification, object: nil)
        defaultsChanged()
        
    }
    
    class func applyQuizLength() {
        
        if UserDefaults.standard.bool(forKey: "short_quiz") {
            QuestionModel.shared.questions = QuestionModel.shared.short
            
        } else {
            QuestionModel.shared.questions = QuestionModel.shared.long
        }
        
    }
    
}


