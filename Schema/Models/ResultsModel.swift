//
//  ResultsModel.swift
//  YSQ
//
//  Created by Itay Garbash on 02/02/2020.
//  Copyright © 2020 Lazy Bear Apps. All rights reserved.
//

import Foundation
import RealmSwift

public class ResultsModel: Object {
   
    public static let shared = ResultsModel()
    
    dynamic var resultArray = List<Int>()
    
    dynamic var name: String = ""
    
    public dynamic var isProgressSaved = false

}
