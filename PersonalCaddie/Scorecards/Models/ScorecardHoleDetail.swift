//
//  ScorecardHoleDetail.swift
//  PersonalCaddie
//
//  Created by Philip Baker on 11/12/18.
//  Copyright © 2018 67442. All rights reserved.
//

import Foundation

struct ScorecardHoleDetail {
  var id: Int
  var holeId: Int
  var number: Int
  var par: Int
  var distance: Int
  var numStrokes: Int
  
  init(id: Int, holeId: Int, number: Int, par: Int, distance: Int, numStrokes: Int){
    self.id = id
    self.holeId = holeId
    self.number = number
    self.par = par
    self.distance = distance
    self.numStrokes = numStrokes
  }
  
}
