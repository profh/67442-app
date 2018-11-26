//
//  NewScorecardViewModel.swift
//  PersonalCaddie
//
//  Created by Philip Baker on 11/14/18.
//  Copyright © 2018 67442. All rights reserved.
//

import Foundation

class NewScorecardViewModel {
  
  let networkClient: NetworkClient
  let parser: AddScorecardParser
  var holes: [Hole]
  var course: Course?
  var courses: [Course]
  var scorecardId: Int?

  
  var holesPlayed: [[Stroke]]
  var strokes: [Stroke]
  
  init(){
    networkClient = NetworkClient()
    parser = AddScorecardParser()
    holes = []
    strokes = []
    holesPlayed = []
    
    courses = []
    
    
  }
  
  func reset(){
    strokes = []
    holesPlayed = []
  }
  
  func refresh(completion: @escaping () -> Void, courseId: Int) {
    networkClient.fetchHoles({  data in
      if let holes = self.parser.parseHolesResponse(data){
        self.holes = holes
        print(self.holes)
      }
      completion()
      
    }, courseId: courseId)
  }
  
  var numberOfHoles: Int{
    return self.holes.count
  }
  
  
  
  func refreshCourses(completion: @escaping () -> Void) {
    networkClient.fetchCourses{  data in
      
      if let courses = self.parser.parseCoursesResponse(data){
        self.courses = courses
      }
      completion()
      
    }
  }
  
  var numberOfCourses: Int{
    return self.courses.count
  }
  
  var numberOfHolesPlayed: Int {
    return self.holesPlayed.count
  }
  

  func createScorecard(courseId: Int) {
    networkClient.createScorecard({  data in
      
      if let scorecardId = self.parser.parseCreateScorecardResponse((data)!){
        self.scorecardId = scorecardId
      }

    }, courseId: courseId)
    

  }

  

}
