//
//  NetworkClient.swift
//  PersonalCaddie
//
//  Created by Philip Baker on 11/12/18.
//  Copyright © 2018 67442. All rights reserved.
//

import Foundation
import Alamofire


let MY_API_KEY = "8469e22bcd93b82c15a94c463cb3f00f5913fcb2"



class NetworkClient{
  
  var headers: HTTPHeaders
  let path: String
  var token: String
  
  init(){
    token = ""
    
    let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
    path = paths[0].stringByAppendingPathComponent(aPath: "UserInfo.plist")
    
    if FileManager.default.fileExists(atPath: path) {
      if let data = NSData(contentsOfFile: path) {
        let unarchiver = NSKeyedUnarchiver(forReadingWith: data as Data)
        token = unarchiver.decodeObject(forKey: "token") as! String
        unarchiver.finishDecoding()
      } else {
        print("\nFILE NOT FOUND AT: \(path)")
      }
    }
    headers = [
      "Authorization": "Token " + token
    ]

  }
  
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
  
  func documentsDirectory() -> String {
    let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
    return paths[0]
  }
  
  func dataFilePath() -> String {
    return documentsDirectory().stringByAppendingPathComponent(aPath: "UserInfo.plist")
  }

  
  
}
