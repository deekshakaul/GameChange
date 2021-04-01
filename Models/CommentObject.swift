//
//  IssueDetailObject.swift
//  TableView
//
//  Created by Deeksha Kaul on 01/04/21.
//  Copyright © 2021 Deeksha Kaul. All rights reserved.
//

import Foundation
import RealmSwift

public class CommentObject: Object {
    @objc dynamic var id: String = ""
    @objc dynamic var userName: String?
    @objc dynamic var body: String?
    @objc dynamic var updatedTimestamp: Date = Date()
    @objc dynamic var htmlUrl: String?
    
    override public static func primaryKey() -> String? {
        return "id"
    }
    
    convenience init(id: String,
                     userName: String?,
                     body: String?,
                     htmlUrl: String?,
                     updatedTimeStamp: Date) {
        self.init()
        self.id = id
        self.userName = userName
        self.body = body
        self.updatedTimestamp = updatedTimeStamp
        self.htmlUrl = htmlUrl
    }
}
