//
//  FetchData.swift
//  TableView
//
//  Created by Deeksha Kaul on 30/03/21.
//  Copyright © 2021 Deeksha Kaul. All rights reserved.
//

import Foundation

public class IssueListViewModel {
    
    func fetchIssues( completion : @escaping ([IssueObject]) ->Void) {
        let url = URL(string: "https://api.github.com/repos/firebase/firebase-ios-sdk/issues?sort=created")
        let task = URLSession.shared.dataTask(with: url!) { (data, response, error) in
            guard let unwrappedData = data else { print("API.Error".localizedValue())
                return }
            do {
                var issueList: [IssueObject] = []
                let str = try JSONSerialization.jsonObject(with: unwrappedData, options: .allowFragments) as! NSArray
                for result in str {
                    let data = result as! NSDictionary

                    let title = data["title"] as? String
                    let body = data["body"] as? String
                    let url = data["comments_url"] as! String
                    let commentUrl = url.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
                    let updatedTimeStamp = Date()
                    let htmlUrl = data["html_url"] as! String
                    let issue = IssueObject(title: title, body: body, commentUrl: commentUrl, htmlUrl: htmlUrl, updatedTimeStamp: updatedTimeStamp)
                    issueList.append(issue)
                }
                completion(issueList)
            } catch {
                print(String(format: "JSON.Error".localizedValue(), error.localizedDescription))
            }
        }

        task.resume()
    }
}

