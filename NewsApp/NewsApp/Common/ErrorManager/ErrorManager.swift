//
//  ErrorManager.swift
//  NewsApp
//
//  Created by Shakti Prakash  on 06/02/21.
//

import Foundation
import Foundation
import Combine

public enum NAError: Error {
  case alert(title: String, message: String?, code: Int)
}

extension NAError: LocalizedError {
  public var errorDescription: String? {
    switch self {
    case .alert(_, let message, _): return message?.localized
    }
  }
  
  public var title: String {
    switch self {
    case .alert(let title,_, _): return title.localized
      
    }
  }
  
  public var code: Int? {
    switch self {
    case .alert(_, _, let code): return code
      
    }
  }
}

extension NAError {
    static func unknownError() -> NAError {
        return NAError.alert(title: "something_wrong".localized, message: "try_again".localized, code: 0)
    }
    
    static func decodingError() -> NAError {
        return NAError.alert(title: "decoding_error".localized, message: "try_again".localized, code: 0)
    }
    
    static func netWorkError() -> NAError {
        return NAError.alert(title: "network_error".localized, message: "try_again".localized, code: 0)
    }
    
}

