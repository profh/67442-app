//
//  CourseDetailViewModel.swift
//  PersonalCaddie
//
//  Created by Philip Baker on 11/30/18.
//  Copyright © 2018 67442. All rights reserved.
//

import Foundation

class CourseDetailViewModel {
  
  var strokes: [ReadStroke]
  var course: CourseOverview
  var networkClient: NetworkClient
  var parser: CourseParser
  
  
  init(_ c: CourseOverview) {
    networkClient = NetworkClient()
    parser = CourseParser()
    course = c
    strokes = []
    
  }
  
  func refresh(){
    networkClient.fetchStrokes({data in
            if let strokes = self.parser.parseStrokesResponse(data!){
              self.strokes = strokes
      
            }
      
          }, courseId: self.course.courseId)
    }
  
  
//  var numberOfHolesPlayed: Int{
//    return course.numHolesPlayed
//  }
//
//  func refresh(completion: @escaping () -> Void) {
//    networkClient.fetchScorecardDetail({  data in
//      if let scorecard = self.parser.parseScorecardDetailResponse(data!){
//        self.scorecard = scorecard
//
//      }
//
//      completion()
//
//    }, scorecardId: self.scorecardOverview!.scorecardId)
//  }
}
