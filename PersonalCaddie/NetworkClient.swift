//
//  NetworkClient.swift
//  PersonalCaddie
//
//  Created by Philip Baker on 11/12/18.
//  Copyright © 2018 67442. All rights reserved.
//

import Foundation
import Alamofire


let MY_API_KEY = "5d193190fca2fcb12d1fef5edd5e5f5f3b95aa72"

let headers: HTTPHeaders = [
  "Authorization": "Token " + MY_API_KEY
]


class NetworkClient {
  
  func fetchScorecardOverviews(_ completion: @escaping (Data?) -> Void) {
    
    let urlString = "https://personalcaddieapi.herokuapp.com/scorecards/"
    
    
    Alamofire.request(urlString, headers: headers).response { response in
      if let error = response.error {
        print("Error fetching scorecard overviews: \(error)")
        completion(response.data)
        return
      }
      completion(response.data)
    }
    
  }
  
  func fetchScorecardDetail(_ completion: @escaping (Data?) -> Void, scorecardId: Int) {
    
    let urlString = "https://personalcaddieapi.herokuapp.com/scorecards/\(scorecardId)/"
    Alamofire.request(urlString, headers: headers).responseJSON { response in
      if let error = response.error {
        print("Error fetching scorecard detail: \(error)")
        completion(response.data)
        return
      }
      completion(response.data)
    }
    
  }
  
  func fetchCourses(_ completion: @escaping (Data?) -> Void) {
    
    let urlString = "https://personalcaddieapi.herokuapp.com/courses/"
    
    Alamofire.request(urlString, headers: headers).response { response in
      if let error = response.error {
        print("Error fetching courses: \(error)")
        completion(response.data)
        return
      }
      completion(response.data)
    }
    
  }
  
  func fetchHoles(_ completion: @escaping (Data?) -> Void, courseId: Int) {
    
    let urlString = "https://personalcaddieapi.herokuapp.com/holes/?course_id=\(courseId)"
    
    Alamofire.request(urlString, headers: headers).response { response in
      if let error = response.error {
        print("Error fetching holes: \(error)")
        completion(response.data)
        return
      }
      completion(response.data)
    }
    
  }
  
  
  
  func createScorecard(_ completion: @escaping (Data?) -> Void, courseId: Int){
    let urlString = "https://personalcaddieapi.herokuapp.com/scorecards/"
    
    Alamofire.request(urlString, method: .post, parameters: ["course": courseId], headers: headers).responseJSON { response in

      if let error = response.error {
        print("Error creating scorecard: \(error)")
        completion(response.data)
        return
      }
      completion(response.data)
    }
    
  }
  

  
  
  func createScorecardHole(_ completion: @escaping (Data?) -> Void, scorecardId: Int, holeId: Int){
    let urlString = "https://personalcaddieapi.herokuapp.com/scorecardHoles/"

    Alamofire.request(urlString, method: .post, parameters: ["scorecard": scorecardId, "hole": holeId], headers: headers).responseJSON { response in
      if let error = response.error {
        print("Error creating scorecard hole: \(error)")
        completion(response.data)
        return
      }
      completion(response.data)
    }
    
  }
  
  func createStroke(scHole: Int, stroke: Stroke){
    let urlString = "https://personalcaddieapi.herokuapp.com/strokes/"
    let params: [String: Any]  = ["scorecardHole": scHole, "club": stroke.club, "lat": stroke.lat, "lon": stroke.lon, "contactType": stroke.contactType!, "flightType": stroke.flightType!, "finalLocation": stroke.finalLocation!]
    
    Alamofire.request(urlString, method: .post, parameters: params, headers: headers).responseJSON { response in
      if let error = response.error {
        print("Error creating stroke: \(error)")

        return
      }
    }
  }
  
  
  
  func fetchCourseOverviews(_ completion: @escaping (Data?) -> Void) {
    
    let urlString = "https://personalcaddieapi.herokuapp.com/courses/"
    
    
    Alamofire.request(urlString, headers: headers).response { response in
      if let error = response.error {
        print("Error fetching course overviews: \(error)")
        completion(response.data)
        return
      }
      completion(response.data)
    }
    
  }
  
  
  func fetchStrokesForCourse(_ completion: @escaping (Data?) -> Void, courseId: Int) {
    
    let urlString = "https://personalcaddieapi.herokuapp.com/strokes/?course_id=\(courseId)"
    
    
    Alamofire.request(urlString, headers: headers).response { response in
      if let error = response.error {
        print("Error fetching course overviews: \(error)")
        completion(response.data)
        return
      }
      completion(response.data)
    }
    
  }
  
  func fetchStrokesForScorecard(_ completion: @escaping (Data?) -> Void, scorecardId: Int) {
    
    let urlString = "https://personalcaddieapi.herokuapp.com/strokes/?scorecard_id=\(scorecardId)"

    Alamofire.request(urlString, headers: headers).responseJSON { response in
      if let error = response.error {
        print("Error fetching course overviews: \(error)")
        completion(response.data)
        return
      }
      completion(response.data)
    }

    
  }
  
  func fetchStrokes(_ completion: @escaping (Data?) -> Void) {
    
    let urlString = "https://personalcaddieapi.herokuapp.com/strokes/"
    
    
    Alamofire.request(urlString, headers: headers).response { response in
      if let error = response.error {
        print("Error fetching course overviews: \(error)")
        completion(response.data)
        return
      }
      completion(response.data)
    }
    
  }
  
  
}
