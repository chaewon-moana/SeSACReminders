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
                print(realm.configuration.fileURL)
            }
        } catch {
            print("todoTableRepo create error")
        }
    }
    
    func fetchAllRecord() -> Results<TodoTable> {
        return realm.objects(TodoTable.self)
    }
    func fetchAllRecordCount() -> Int {
        return realm.objects(TodoTable.self).count
    }
    
    func fetchDoneRecordCount() -> Int {
        return realm.objects(TodoTable.self).where {
            $0.done == true
        }.count
    }
    
    func sortedTitleAscending(ascending: Bool) -> Results<TodoTable> { //true - 오름차순, false - 내림차순
        return realm.objects(TodoTable.self).sorted(byKeyPath: "title", ascending: ascending)
    }
    
    func updateDoneAttribute(index: Int) {
        let list = realm.objects(TodoTable.self)
        let tmp = list[index]
        do {
            try realm.write {
                tmp.done.toggle()
            }
        } catch {
            print("TodoTableRepository update Done 에러")
        }
    }
}
