//
//  NetworkManager.swift
//  NewsApp
//
//  Created by Shakti Prakash  on 06/02/21.
//

import Foundation
import Combine

class NewsApiFetcher {
    
    private let session: URLSession
    
    init(session: URLSession = .shared) {
        self.session = session
    }
    
    
    private func performAPIRequest<T: Decodable>(with components: URLComponents) -> AnyPublisher <T, NAError> {
        guard let url = components.url  else {
            let error = NAError.unknownError()
            return Fail(error: error).eraseToAnyPublisher()
        }
        return session.dataTaskPublisher(for: URLRequest(url: url))
            .mapError {  error in
                NAError.decodingError()
            }
            .map(\.data)
            .flatMap { data in
                decode(data)
            }
            .eraseToAnyPublisher()
    }
    
   // MARK:- This function is used for creating url components
    
    func makeNewsDetailsURLComponents() -> URLComponents {
        var components = URLComponents()
        components.scheme = NewsRequestConstants.scheme
        components.host = NewsRequestConstants.host
        components.path = NewsRequestConstants.path
        components.queryItems = [
            URLQueryItem(name: "country", value: "in"),
            URLQueryItem(name: "apiKey", value: NewsRequestConstants.key)
        ]
        return components
    }
}



extension NewsApiFetcher: NewsDetailsFetchable {
    func getNewsDetails() -> AnyPublisher<NewsDetails, NAError> {
        return performAPIRequest(with: makeNewsDetailsURLComponents())
    }
}
