//
//  ScorecardOverview.swift
//  PersonalCaddie
//
//  Created by Philip Baker on 11/12/18.
//  Copyright © 2018 67442. All rights reserved.
//

import Foundation

struct ScorecardOverview {
  var scorecardId: Int
  var date: Date
  var userId: Int
  var courseId: Int
  var numHolesPlayed: Int
  var numStrokes: Int
  var numPutts: Int
  var courseName: String
  var nineHolePar: Int
  var eighteenHolePar: Int
  
  init(scorecardId: Int, date: Date, userId: Int, courseId: Int, numHolesPlayed: Int, numStrokes: Int, numPutts: Int, courseName: String, nineHolePar: Int, eighteenHolePar: Int){
    
    self.scorecardId = scorecardId
    self.date = date
    self.userId = userId
    self.courseId = courseId
    self.numHolesPlayed = numHolesPlayed
    self.numStrokes = numStrokes
    self.numPutts = numPutts
    self.courseName = courseName
    self.nineHolePar = nineHolePar
    self.eighteenHolePar = eighteenHolePar
  }
  
  func getParToDisplay() -> Int {
    if self.numHolesPlayed > 9{
      return self.eighteenHolePar
    }
    else {
      return self.nineHolePar
    }
  }
  
  
}
