//
//  RealmModel.swift
//  SeSACReminders
//
//  Created by cho on 2/15/24.
//

import Foundation
import RealmSwift

class TodoTable: Object {
    @Persisted(primaryKey: true) var id: ObjectId
    @Persisted var title: String
    @Persisted var memo: String?
    @Persisted var dueDate: String?
    @Persisted var tag: String?
    @Persisted var priority: Int?
    
    convenience init(title: String, memo: String? = nil, dueDate: String? = nil, tag: String? = nil, priority: Int? = nil) {
        self.init()
        self.title = title
        self.memo = memo
        self.dueDate = dueDate
        self.tag = tag
        self.priority = priority 
    }
}
