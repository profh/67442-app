//
//  AddScorecardParser.swift
//  PersonalCaddie
//
//  Created by Philip Baker on 11/14/18.
//  Copyright © 2018 67442. All rights reserved.
//



import Foundation
import Alamofire
import SwiftyJSON

class AddScorecardParser {
  
  func parseCoursesResponse(_ data: Data? ) -> [Course]?{
    var courses: [Course] = []
    do {
      if let swiftyjson = try? JSON(data: data! ){
        
        
        for (_, course):(String, JSON) in swiftyjson {
          let courseId = course["id"].int
          let name = course["name"].string
          let street = course["street"].string
          let city = course["city"].string
          let state = course["state"].string
          let zip_code = course["zip_code"].string
          let nineHolePar = course["nineHolePar"].int
          let eighteenHolePar = course["eighteenHolePar"].int
          let numScorecards = course["numScorecards"].int
          let numHolesPlayed = course["numHolesPlayed"].int
          let numPutts = course["numPutts"].int
          

          courses.append(Course(courseId: courseId!, name: name!, street: street!, city: city!, state: state!, zip_code: zip_code!, nineHolePar: nineHolePar!, eighteenHolePar: eighteenHolePar!, numScorecards: numScorecards!, numHolesPlayed: numHolesPlayed!, numPutts: numPutts!))
          
        }
        
        
        return courses
      }
    }
    catch {
      print("error serializing json: \(error)")
      
    }
    
    return nil
  
  }
  

  
  func parseHolesResponse(_ data: Data? ) -> [Hole]?{
    var holes: [Hole] = []
    do {
      if let swiftyjson = try? JSON(data: data! ){
        
        
        for (_, hole):(String, JSON) in swiftyjson {
          let holeId = hole["id"].int
          let course = hole["course"].int
          let number = hole["number"].int
          let par = hole["par"].int
          let distance = hole["distance"].int
          
          
          holes.append(Hole(holeId: holeId!, course: course!, number: number!, par: par!, distance: distance!))
          
        }
        
        
        return holes
      }
    }
    catch {
      print("error serializing json: \(error)")
      
    }
    
    return nil
    
  }
  
  
  
}
