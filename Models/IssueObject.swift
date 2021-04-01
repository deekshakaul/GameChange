//
//  IssueObject.swift
//  TableView
//
//  Created by Deeksha Kaul on 01/04/21.
//  Copyright © 2021 Deeksha Kaul. All rights reserved.
//

import Foundation
import RealmSwift

public class IssueObject: Object {
    @objc dynamic var title: String?
    @objc dynamic var body: String?
    @objc dynamic var commentUrl: String = ""
    @objc dynamic var updatedTimeStamp: Date = Date()
    @objc dynamic var htmlUrl: String?
    
    override public static func primaryKey() -> String? {
        return "commentUrl"
    }
    
    convenience init(title: String?,
                     body: String?,
                     commentUrl: String = "",
                     htmlUrl: String?,
                     updatedTimeStamp: Date) {
        self.init()
        self.title = title
        self.body = body
        self.commentUrl = commentUrl
        self.htmlUrl = htmlUrl
        self.updatedTimeStamp = updatedTimeStamp
    }
}
