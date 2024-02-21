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
    
    func fetchListRecord(name: String) -> Results<CustomList> {
        return realm.objects(CustomList.self).where {
            $0.name == name
        }
    }
    
    func fetchListName() -> [String] {
        let data = realm.objects(CustomList.self)
        var result: [String] = []
        for i in data {
            result.append(i.name)
        }
     return result
    }
}
