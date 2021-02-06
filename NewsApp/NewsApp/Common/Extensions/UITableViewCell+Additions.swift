//
//  UITableViewCell+Additions.swift
//  NewsApp
//
//  Created by Shakti Prakash  on 06/02/21.
//

import UIKit

extension UITableViewCell {
  /// This identifier tells about the own class type
  class var identifier: String {
    return NSStringFromClass(self).components(separatedBy: ".").last!
  }
}
