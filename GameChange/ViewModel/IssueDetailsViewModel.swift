//
//  IssueDetailsViewModel.swift
//  TableView
//
//  Created by Deeksha Kaul on 31/03/21.
//  Copyright © 2021 Deeksha Kaul. All rights reserved.
//

import Foundation

public class IssueDetailsViewModel {

    func fetchIssueDetails(url: String, completion : @escaping ([CommentObject]) ->Void) {
        let endpoint = URL(string: url)
        let task = URLSession.shared.dataTask(with: endpoint!) { (data, response, error) in
            guard let unwrappedData = data else {
                print("API.Error".localizedValue())
                return }
            do {
                var issueDetails: [CommentObject] = []
                let str = try JSONSerialization.jsonObject(with: unwrappedData, options: .allowFragments) as! NSArray
                for result in str {
                    let detail = result as! NSDictionary
                    let comment = CommentObject()
                    let user = detail["user"] as! NSDictionary
                    comment.userName = String(describing: user["login"])
                    comment.body = String(describing: detail["body"])
                    comment.id = String(describing: detail["id"])
                    comment.updatedTimestamp = Date()
                    issueDetails.append(comment)
                }
                completion(issueDetails)
            } catch {
                print(String(format: "JSON.Error".localizedValue(), error.localizedDescription))
            }
        }
        
        task.resume()
    }
}
