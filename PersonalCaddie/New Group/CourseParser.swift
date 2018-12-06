//
//  File.swift
//  PersonalCaddie
//
//  Created by Philip Baker on 11/29/18.
//  Copyright © 2018 67442. All rights reserved.
//

import Foundation
import SwiftyJSON


class CourseParser {

  func parseCourseOverviewResponse(_ data: Data? ) -> [CourseOverview]?{
    var courseOverviews: [CourseOverview] = []

    do {
      if let swiftyjson = try? JSON(data: data! ){
        
        for (_, courseOverview):(String, JSON) in swiftyjson {
          let courseId = courseOverview["id"].int
          let name = courseOverview["name"].string
          let street = courseOverview["street"].string
          let city = courseOverview["city"].string
          let state = courseOverview["state"].string
          let zip_code = courseOverview["zip_code"].string
          let nineHolePar = courseOverview["nineHolePar"].int
          let eighteenHolePar = courseOverview["eighteenHolePar"].int
          let numScorecards = courseOverview["numScorecards"].int
          let numHolesPlayed = courseOverview["numHolesPlayed"].int
          let numPutts = courseOverview["numPutts"].int
          
          courseOverviews.append(CourseOverview(courseId: courseId!, name: name!, street: street!, city: city!, state: state!, zip_code: zip_code!, nineHolePar: nineHolePar!, eighteenHolePar: eighteenHolePar!, numScorecards: numScorecards!, numHolesPlayed: numHolesPlayed!, numPutts: numPutts!))
        }

        return courseOverviews
      }
    }
    catch {
      print("error serializing json: \(error)")
      
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
