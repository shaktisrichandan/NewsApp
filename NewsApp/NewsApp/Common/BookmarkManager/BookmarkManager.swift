//
//  BookmarkManager.swift
//  NewsApp
//
//  Created by Shakti Prakash  on 06/02/21.
//

import Foundation

class BookmarkManager {
    
    static let shared = BookmarkManager()
    
    private init() {}
    
    var bookMarkedArticles: [Displayable] = []
    
    func add(_ article: Displayable) {
        if !(self.bookMarkedArticles.contains(where: {$0.articleID == article.articleID})) {
            self.bookMarkedArticles.append(article)
        }
      
    }
    
}
