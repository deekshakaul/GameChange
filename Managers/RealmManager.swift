//
//  RealmManager.swift
//  GameChange
//
//  Created by Deeksha Kaul on 01/04/21.
//  Copyright © 2021 Deeksha Kaul. All rights reserved.
//

import Foundation
import RealmSwift

class RealmManager: NSObject {
    
    static public func realm() -> Realm {
        do {
            let realm = try Realm()
            return realm
        } catch {
            fatalError("Failed to instantiate Realm \(error)")
        }
    }

    static public func add(objects: [Object]) {
        let realm = self.realm()

        do {
            try realm.write {
                for object in objects {
                    realm.add(object, update: .all)
                }
            }
        } catch {
            print("Failed to add object to Realm \(error)")
        }
    }
    
    static public func deleteAll() {
        let realm = self.realm()

        do {
            try realm.write {
                realm.deleteAll()
            }
        } catch {
            print("Failed to add object to Realm \(error)")
        }
    }
    
}
