//
//  FetchData.swift
//  TableView
//
//  Created by Deeksha Kaul on 30/03/21.
//  Copyright © 2021 Deeksha Kaul. All rights reserved.
//

import Foundation

public class IssueListViewModel {

    func fetchIssues( completion : @escaping (NSArray) ->Void) {
        let url = URL(string: "https://api.github.com/repos/firebase/firebase-ios-sdk/issues?sort=created")
        let task = URLSession.shared.dataTask(with: url!) { (data, response, error) in
            guard let unwrappedData = data else { print("API.Error".localizedValue())
                return }
            do {
                let str = try JSONSerialization.jsonObject(with: unwrappedData, options: .allowFragments) as! NSArray
                completion(str)
            } catch {
                print(String(format: "JSON.Error".localizedValue(), error.localizedDescription))
            }
        }
        
        task.resume()
    }
}

