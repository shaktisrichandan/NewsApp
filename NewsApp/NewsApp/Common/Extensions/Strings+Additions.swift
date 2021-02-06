//
//  Strings+Additions.swift
//  NewsApp
//
//  Created by Shakti Prakash  on 06/02/21.
//
import Foundation

extension String {
    
    var localized: String {
        return NSLocalizedString(self, comment: self)
    }
    
    func localized(withComment comment: String) -> String {
        return NSLocalizedString(self, comment: comment)
    }
 
}
