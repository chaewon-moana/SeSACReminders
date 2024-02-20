//
//  CustomListRepository.swift
//  SeSACReminders
//
//  Created by cho on 2/20/24.
//

import Foundation
import RealmSwift

final class CustomListRepository {
    private let realm = try! Realm()
    
    func createRecord(record: CustomList) {
        do {
            try realm.write {
                realm.add(record)
            }
        } catch {
            print("customListRepo createRecord Error")
        }
    }
    
    func fetchAllRecords() -> Results<CustomList> {
        return realm.objects(CustomList.self)
    }
}
