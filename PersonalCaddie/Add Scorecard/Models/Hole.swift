//
//  File.swift
//  PersonalCaddie
//
//  Created by Philip Baker on 11/14/18.
//  Copyright © 2018 67442. All rights reserved.
//

import Foundation


struct Hole {
  var holeId: Int
  var course: Int
  var number: Int
  var par: Int
  var distance: Int
  
  init(holeId: Int, course: Int, number: Int, par: Int, distance: Int){
    self.holeId = holeId
    self.course = course
    self.number = number
    self.par = par
    self.distance = distance
  }
}
