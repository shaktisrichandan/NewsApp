//
//  News.swift
//  NewsApp
//
//  Created by Shakti Prakash  on 06/02/21.
//

import Foundation

import Foundation

// MARK: - News
struct NewsDetails: Codable {
    let status: String
    let totalResults: Int
    let articles: [Article]?
    
    enum CodingKeys: String, CodingKey {
        case status, totalResults, articles
    }
    
    init(from decoder: Decoder) throws  {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        status = try container.decodeIfPresent(String.self, forKey: .status) ?? SpacingConstants.emptyString
        totalResults = try container.decodeIfPresent(Int.self, forKey: .totalResults) ?? 0
        articles = try container.decodeIfPresent([Article].self, forKey: .articles)
    }
    
}

// MARK: - Article
struct Article: Codable {
    let source: Source?
    let author: String
    let title, articleDescription: String
    let url: String
    let urlToImage: String
    let publishedAt: String
    let content: String

    enum CodingKeys: String, CodingKey {
        case source, author, title
        case articleDescription = "description"
        case url, urlToImage, publishedAt, content
    }
    
    init(from decoder: Decoder) throws  {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        author = try container.decodeIfPresent(String.self, forKey: .author) ?? SpacingConstants.emptyString
        source = try container.decodeIfPresent(Source.self, forKey: .source)
        title = try container.decodeIfPresent(String.self, forKey: .title) ?? SpacingConstants.emptyString
        articleDescription = try container.decodeIfPresent(String.self, forKey: .articleDescription) ?? SpacingConstants.emptyString
        url = try container.decodeIfPresent(String.self, forKey: .url) ?? SpacingConstants.emptyString
        urlToImage = try container.decodeIfPresent(String.self, forKey: .urlToImage) ?? SpacingConstants.emptyString
        publishedAt = try container.decodeIfPresent(String.self, forKey: .publishedAt) ?? SpacingConstants.emptyString
        content = try container.decodeIfPresent(String.self, forKey: .publishedAt) ?? SpacingConstants.emptyString
    }
}


// MARK: - Source
struct Source: Codable {
    let id: String
    let name: String
    
    enum CodingKeys: String, CodingKey {
        case id, name
    }
    
    init(from decoder: Decoder) throws  {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decodeIfPresent(String.self, forKey: .id) ?? UUID().uuidString
        name = try container.decodeIfPresent(String.self, forKey: .name) ?? SpacingConstants.emptyString
    }
}


extension Article: Displayable  {
  
    
    var articleID: String {
        return source?.id ?? UUID().uuidString
    }
    
    var articleTitle: String {
        return title
    }
    
    var articleLink: String {
        return url
    }
    
    var articleImageURL: String {
        return urlToImage
    }
    
    var articleSource: String {
        return source?.name ?? SpacingConstants.emptyString
    }
    
    var articleSubTitle: String {
        return articleDescription
    }
    
}
