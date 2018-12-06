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

  func parseScorecardDetailResponse(_ data: Data) -> ScorecardDetail?{
    
    var scorecard: ScorecardDetail
    let f = DateFormatter()
    f.dateFormat = "yyyy-MM-dd"
    if let swiftyjson = try? JSON(data: data ){
      var scorecardHoles: [ScorecardHoleDetail] = []
      let scorecardId = swiftyjson["id"].int
      let date = f.date(from: swiftyjson["date"].string!)
      let courseId = swiftyjson["course"]["id"].int
      let courseName = swiftyjson["course"]["name"].string
      let nineHolePar = swiftyjson["course"]["nineHolePar"].int
      let eighteenHolePar = swiftyjson["course"]["eighteenHolePar"].int
      let numPutts = swiftyjson["numPutts"].int
      var totalStrokes = 0
      
      for (_, scHole):(String, JSON) in swiftyjson["scorecardHoles"]{
        let schId = scHole["id"].int
        let holeId = scHole["hole"]["id"].int
        let number = scHole["hole"]["number"].int
        let par = scHole["hole"]["par"].int
        let distance = scHole["hole"]["distance"].int
        let numStrokes = scHole["numStrokes"].int
        
        totalStrokes += numStrokes!
        scorecardHoles.append(ScorecardHoleDetail(id: schId!, holeId: holeId!, number: number!, par: par!, distance: distance!, numStrokes: numStrokes!))
      }
      scorecard = ScorecardDetail(scorecardId: scorecardId!, date: date!, courseId: courseId!, courseName: courseName!, nineHolePar: nineHolePar!, eighteenHolePar: eighteenHolePar!, numPutts: numPutts!, numStrokes: totalStrokes, numHolesPlayed: scorecardHoles.count, scorecardHoles: scorecardHoles)
      return scorecard
    }
    return nil
  }
  
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
