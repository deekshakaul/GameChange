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
        print(url)
        let task = URLSession.shared.dataTask(with: endpoint!) { (data, response, error) in
            guard let unwrappedData = data else {
                print("API.Error".localizedValue(), "$$$$$$$$$")
                return }
            do {
                var issueDetails: [CommentObject] = []
                let str = try JSONSerialization.jsonObject(with: unwrappedData, options: .allowFragments) as! NSArray
                for result in str {
                    let detail = result as! NSDictionary
                    let comment = CommentObject()
                    let user = detail["user"] as! NSDictionary
                    comment.userName = String(describing: user["login"] as! String)
                    comment.body = String(describing: detail["body"] as! String)
                    issueDetails.append(comment)
                }
                completion(issueDetails)
            } catch {
                print("JSON.Error".localizedValue(), error.localizedDescription)
            }
        }
        
        task.resume()
    }
}
