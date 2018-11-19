//
//  ScorecardCourseViewModel.swift
//  PersonalCaddie
//
//  Created by Philip Baker on 11/14/18.
//  Copyright © 2018 67442. All rights reserved.
//

import Foundation

class ScorecardCourseViewModel {
  var parser: AddScorecardParser
  var networkClient: NetworkClient
  var courses: [Course]
  
  var course: Course?
  
  init(){
    parser = AddScorecardParser()
    networkClient = NetworkClient()
    courses = []
  }
  
  func refresh(completion: @escaping () -> Void) {
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
  
}
