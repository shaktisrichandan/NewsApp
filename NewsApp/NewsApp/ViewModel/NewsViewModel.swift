//
//  NewsViewModel.swift
//  NewsApp
//
//  Created by Shakti Prakash  on 06/02/21.
//

import Foundation
import Combine


enum NewsCellType: Int {
    case topNews = 0
    case popularNewsHeading
    case popularNews
    case bottombanner
    
}
class NewsViewModel: BaseViewModel {
    var requestStatusChanged: ((_ inProgress: Bool) -> Void)?
    var requestSucceeded: (() -> Void)?
    var requestEncounteredError: ((_ error: NAError?) -> Void)?
    var cellIndexes = [NewsCellType] ()
    
    private var disposables = Set<AnyCancellable>()
    private lazy var articles: [Article]  = []
    private var topNews: Article?
    
    var sectionCount: Int {
        return cellIndexes.count
    }
    var articleCount: Int  {
        return self.articles.count
    }
    
    var topNewsItem: Article {
        return topNews!
    }
    
    func itemAt(_ index: Int) -> Article {
        return self.articles[index]
    }
    
    func fetchNewsHeadlines() {
        self.requestStatusChanged?(true)
        NewsApiFetcher().getNewsDetails()
            .receive(on: DispatchQueue.main)
            .sink { [weak self] completion in
                guard let self = self else { return }
                self.requestStatusChanged?(false)
                switch completion {
                case .finished: debugPrint("Completion")
                    
                case .failure(let error ): debugPrint(" Error Occured \(error)")
                    self.requestEncounteredError?(error)
                }
            } receiveValue: { [weak self] newsdetails in
                guard let self = self else { return }
                var articles = newsdetails.articles ?? []
                if articles.count > 0 {
                    self.cellIndexes.append(.topNews)
                    self.topNews = articles[0]
                }
                if articles.count > 1 {
                    articles.remove(at: 0)
                    self.articles = articles
                    self.cellIndexes.append(.popularNewsHeading)
                    self.cellIndexes.append(.popularNews)
                    self.cellIndexes.append(.bottombanner)
                }
                self.requestSucceeded?()
              
            }
            .store(in: &disposables)
    }
    
    
}

