//
//  File.swift
//  YSQ
//
//  Created by itay gervash on 18/02/2020.
//  Copyright © 2020 Lazy Bear Apps. All rights reserved.
//

import Foundation
import RealmSwift

class SavedResult: Object {
    
    @objc dynamic var name: String = ""
    dynamic var result = List<Int>()
    @objc dynamic var date: Date?
    
}
