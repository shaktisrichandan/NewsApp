//
//  BookmarkViewModel.swift
//  NewsApp
//
//  Created by Shakti Prakash  on 06/02/21.
//

import Foundation

class BookmarkViewModel: NewsViewModel {
    
    
    var itemCount: Int {
        return  items.count
    }
   
    private var items: [Displayable] {
        BookmarkManager.shared.bookMarkedArticles
    }
    
    override func itemAt(_ index: Int) -> Article {
        items[index] as! Article
    }
    func fetchBookmarkedarticle() {
        
       if  self.itemCount > 0 {
            self.requestSucceeded?()
        }
        else {
          
            self.requestEncounteredError?(NAError.alert(title: "no_bookmark".localized, message: "add_bookmark".localized, code: 1))
        }
        
    }
    
}
