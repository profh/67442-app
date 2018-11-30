//
//  CourseOverviewViewModel.swift
//  PersonalCaddie
//
//  Created by Philip Baker on 11/28/18.
//  Copyright © 2018 67442. All rights reserved.
//

import Foundation


class CourseOverviewViewModel {

  
  //var scorecards: [ScorecardOverview]
  var parser: CourseParser
  var networkClient: NetworkClient
  var courseOverviews: [CourseOverview]
  init(){
    parser = CourseParser()
    networkClient = NetworkClient()
    courseOverviews = []
  }
  
  func refresh(completion: @escaping () -> Void) {
    networkClient.fetchCourseOverviews{  data in
      
      if let courseOverviews = self.parser.parseCourseOverviewResponse(data){
        self.courseOverviews = courseOverviews
        
      }
      completion()
      
    }
  }
  
  var numberOfCourseOverviews: Int{
    return self.courseOverviews.count
  }
  
}
