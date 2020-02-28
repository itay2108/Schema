//
//  Answers.swift
//  Schema
//
//  Created by itay gervash on 25/02/2020.
//  Copyright © 2020 Lazy Bear Apps. All rights reserved.
//

import Foundation
import RealmSwift

public class Answers: Object {
    public static let shared = Answers()
    
    public dynamic var answers = List<Int>()
    
}
