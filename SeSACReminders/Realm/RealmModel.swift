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
    @Persisted var name: String
    @Persisted var memo: String?
    @Persisted var dueDate: Date?
    @Persisted var tag: String?
    @Persisted var priority: String?
    @Persisted var done: Bool
    @Persisted var flag: Bool
        
    convenience init(name: String, memo: String? = nil, dueDate: Date? = nil, tag: String? = nil, priority: String? = nil) {
        self.init()
        self.name = name
        self.memo = memo
        self.dueDate = dueDate
        self.tag = tag
        self.priority = priority
        self.done = false
        self.flag = false
    }
}

class CustomList: Object {
    @Persisted(primaryKey: true) var id: ObjectId
    @Persisted var name: String
    @Persisted var regDate: Date
    @Persisted var icon: String
    @Persisted var color: String
    
    @Persisted var todo: List<TodoTable>
    
    convenience init(name: String, regDate: Date, icon: String, color: String) {
        self.init()
        self.name = name
        self.regDate = regDate
        self.icon = icon
        self.color = color
    }
}
