//
//  String+Extension.swift
//  TableView
//
//  Created by Deeksha Kaul on 31/03/21.
//  Copyright © 2021 Deeksha Kaul. All rights reserved.
//

import Foundation

extension String {
    
    func localizedValue() -> String {
        return NSLocalizedString(self, comment: "")
    }
    
   func maxLength(length: Int) -> String {
       var str = self
       let nsString = str as NSString
       if nsString.length >= length {
           str = nsString.substring(with:
               NSRange(
                location: 0,
                length: nsString.length > length ? length : nsString.length)
           )
    }
    // remove last charecter till partial last word is removed
    while !str.isEmpty && str.last != " " {
        _ = str.popLast()
    }
    str = str.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
    return nsString.length > 140 ? str + "..." : str
   }
}
