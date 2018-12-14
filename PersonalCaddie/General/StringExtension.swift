//
//  StringExtension.swift
//  PersonalCaddie
//
//  Created by Philip Baker on 12/6/18.
//  Copyright © 2018 67442. All rights reserved.
//

import Foundation

extension String {
  // recreating a function that String class no longer supports in Swift 2.3
  // but still exists in the NSString class. (This trick is useful in other
  // contexts as well when moving between NS classes and Swift counterparts.)
  
  /**
   Returns a new string made by appending to the receiver a given string.  In this case, a new string made by appending 'aPath' to the receiver, preceded if necessary by a path separator.
   
   - parameter aPath: The path component to append to the receiver. (String)
   
   - returns: A new string made by appending 'aPath' to the receiver, preceded if necessary by a path separator. (String)
   
   */
  func stringByAppendingPathComponent(aPath: String) -> String {
    let nsSt = self as NSString
    return nsSt.appendingPathComponent(aPath)
  }
}
