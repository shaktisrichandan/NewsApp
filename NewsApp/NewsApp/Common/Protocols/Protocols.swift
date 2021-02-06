//
//  Protocols.swift
//  NewsApp
//
//  Created by Shakti Prakash  on 06/02/21.
//

import Foundation
import UIKit
import Combine
// MARK: - Protocol to handle common callbacks of view models
protocol BaseViewModel: class {
    // Used to update the request started/ended status. can be usewd to update the activity indicator.
    var requestStatusChanged: ((_ inProgress: Bool) -> Void)? { get set }
    // Used to inform about the error
    var requestEncounteredError: ((_ error: NAError?) -> Void)? { get set }
    
}

//MARK:- API Protocol
protocol NewsDetailsFetchable {
    func getNewsDetails() -> AnyPublisher<NewsDetails ,NAError>
}


protocol Displayable {
    var articleID: String { get }
    var articleTitle: String { get }
    var articleSubTitle: String { get }
    var articleLink: String { get }
    var articleImageURL: String { get }
    var articleSource: String { get }
   
}

