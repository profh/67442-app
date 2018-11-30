//
//  Course.swift
//  PersonalCaddie
//
//  Created by Philip Baker on 11/28/18.
//  Copyright © 2018 67442. All rights reserved.
//

import Foundation

struct CourseOverview {
  var courseId: Int
  var name: String
  var street: String
  var city: String
  var state: String
  var zip_code: String
  var nineHolePar: Int
  var eighteenHolePar: Int
  var numScorecards: Int
  var numHolesPlayed: Int
  var numPutts: Int
  
  init(courseId: Int, name: String, street: String, city: String, state: String, zip_code: String, nineHolePar: Int, eighteenHolePar: Int, numScorecards: Int, numHolesPlayed: Int, numPutts: Int){
    self.courseId = courseId
    self.name = name
    self.street = street
    self.city = city
    self.state = state
    self.zip_code = zip_code
    self.nineHolePar = nineHolePar
    self.eighteenHolePar = eighteenHolePar
    self.numScorecards = numScorecards
    self.numHolesPlayed = numHolesPlayed
    self.numPutts = numPutts
  }
}
