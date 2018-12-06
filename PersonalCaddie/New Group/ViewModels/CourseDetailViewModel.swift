//
//  CourseDetailViewModel.swift
//  PersonalCaddie
//
//  Created by Philip Baker on 11/30/18.
//  Copyright © 2018 67442. All rights reserved.
//

import Foundation
import CoreLocation

class CourseDetailViewModel: ProcessStrokes {
  
  var strokes: [ReadStroke]
  var course: CourseOverview
  var networkClient: NetworkClient
  var parser: CourseParser
  
  var clubStats: [ClubStats] = []
  
  init(_ c: CourseOverview) {
    networkClient = NetworkClient()
    parser = CourseParser()
    course = c
    strokes = []
    
  }
  
  func refresh(completion: @escaping () -> Void ){
    networkClient.fetchStrokesForCourse({data in
            if let strokes = self.parser.parseStrokesResponse(data!){
              self.strokes = strokes
              self.clubStats = self.processStrokes(strokes)
              completion()
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
