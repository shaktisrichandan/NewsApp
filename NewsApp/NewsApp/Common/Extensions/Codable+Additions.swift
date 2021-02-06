//
//  Codable+Additions.swift
//  NewsApp
//
//  Created by Shakti Prakash  on 06/02/21.
//

import Foundation
import Combine

func decode<T: Decodable>(_ data: Data) -> AnyPublisher <T,NAError> {
    let decoder = JSONDecoder()
   return Just(data)
    .decode(type: T.self, decoder: decoder)
    .mapError{ error in
     .decodingError()
    }
    .eraseToAnyPublisher()
    
}
