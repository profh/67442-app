//
//  ScorecardParser.swift
//  PersonalCaddie
//
//  Created by Philip Baker on 11/12/18.
//  Copyright © 2018 67442. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class ScorecardParser {
  
  func parseScorecardOverviewResponse(_ data: Data? ) -> [ScorecardOverview]?{
    var scorecards: [ScorecardOverview] = []
    let f = DateFormatter()
    f.dateFormat = "yyyy-MM-dd"
    do {
      if let swiftyjson = try? JSON(data: data! ){
        
        
        for (_, scorecardOverview):(String, JSON) in swiftyjson {
          let scorecardId = scorecardOverview["id"].int
          let date = f.date(from: scorecardOverview["date"].string!)
          let userId  = scorecardOverview["user"].int
          let courseId = scorecardOverview["course"].int
          let numHolesPlayed = scorecardOverview["numHolesPlayed"].int
          let numStrokes = scorecardOverview["numStrokes"].int
          let numPutts = scorecardOverview["numPutts"].int
          let courseName = scorecardOverview["courseInfo"]["name"].string
          let nineHolePar = scorecardOverview["courseInfo"]["nineHolePar"].int
          let eighteenHolePar = scorecardOverview["courseInfo"]["eighteenHolePar"].int
          
          scorecards.append(ScorecardOverview(scorecardId: scorecardId!, date: date!, userId: userId!, courseId: courseId!, numHolesPlayed: numHolesPlayed!, numStrokes: numStrokes!, numPutts: numPutts!, courseName: courseName!, nineHolePar: nineHolePar!, eighteenHolePar: eighteenHolePar!))
        }
        
        
        return scorecards
      }
    }
    catch {
      print("error serializing json: \(error)")
      
    }
    
    return nil
    
  }
  
  
  
}
