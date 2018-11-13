//
//  ScorecardDetail.swift
//  PersonalCaddie
//
//  Created by Philip Baker on 11/12/18.
//  Copyright © 2018 67442. All rights reserved.
//

import Foundation

struct ScorecardDetail {
  var scorecardId: Int
  var date: Date
  var courseId: Int
  var courseName: String
  var nineHolePar: Int
  var eighteenHolePar: Int
  var numPutts: Int
  var numStrokes: Int
  var numHolesPlayed: Int
  var scorecardHoles: [ScorecardHoleDetail]
  
  init(scorecardId: Int, date: Date, courseId: Int, courseName: String, nineHolePar: Int, eighteenHolePar: Int, numPutts: Int, numStrokes: Int, numHolesPlayed: Int, scorecardHoles: [ScorecardHoleDetail]){
    self.scorecardId = scorecardId
    self.date = date
    self.courseId = courseId
    self.courseName = courseName
    self.nineHolePar = nineHolePar
    self.eighteenHolePar = eighteenHolePar
    self.numPutts = numPutts
    self.numStrokes = numStrokes
    self.numHolesPlayed = numHolesPlayed
    self.scorecardHoles = scorecardHoles
  }
  
}
