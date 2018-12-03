//
//  PlayerCardParser.swift
//  PersonalCaddie
//
//  Created by Philip Baker on 12/3/18.
//  Copyright © 2018 67442. All rights reserved.
//

import Foundation
import SwiftyJSON


class PlayerCardParser {
  
  func parseStrokesResponse(_ data: Data? ) -> [ReadStroke]?{
    var strokes: [ReadStroke] = []
    
    do {
      if let swiftyjson = try? JSON(data: data! ){
        
        for (_, stroke):(String, JSON) in swiftyjson {
          let id = stroke["id"].int
          let scorecardHole = stroke["scorecardHole"].int
          let club = stroke["club"].int
          let lat = stroke["lat"].string
          let lon = stroke["lon"].string
          let contactType = stroke["contactType"].string
          let flightType = stroke["flightType"].string
          let lie = stroke["finalLocation"].string
          
          strokes.append(ReadStroke(id: id!, scorecardHole: scorecardHole!, club: club!, lat: lat!, lon: lon!, contactType: contactType, flightType: flightType, lie: lie))
        }
        
        return strokes
      }
    }
    catch {
      print("error serializing json: \(error)")
      
    }
    
    return nil
    
  }
}
