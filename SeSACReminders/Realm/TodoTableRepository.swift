//
//  TodoTableRepository.swift
//  SeSACReminders
//
//  Created by cho on 2/18/24.
//

import Foundation
import RealmSwift

final class TodoTableRepository {
    private let realm = try! Realm()
    
    func createRecord(_ data: TodoTable) {
        do {
            try realm.write {
                realm.add(data)
            }
        } catch {
            print("todoTableRepo create error")
        }
    }
}
