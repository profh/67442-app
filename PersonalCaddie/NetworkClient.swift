//
//  NetworkClient.swift
//  PersonalCaddie
//
//  Created by Philip Baker on 11/12/18.
//  Copyright © 2018 67442. All rights reserved.
//

import Foundation
import Alamofire


let MY_API_KEY = "36dea5b53e0c46395cb2e1204faf83445299aa92"

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

    Alamofire.request(urlString, headers: headers).response { response in
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
        print("Error fetching scorecard detail: \(error)")
        completion(response.data)
        return
      }
      completion(response.data)
    }
    
  }
}
