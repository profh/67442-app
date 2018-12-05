//
//  ClubStats.swift
//  PersonalCaddie
//
//  Created by Philip Baker on 12/3/18.
//  Copyright © 2018 67442. All rights reserved.
//

import Foundation


struct ClubStats {
  var clubId: Int
  var clubName: String
  var avgDist: Double
  var perfContactPercentage: Double?
  var straightFlightPercentage: Double?
  var expanded: Bool
  
  init(clubId: Int, clubName: String, avgDist: Double, perfContactPercentage: Double?, straightFlightPercentage: Double?){
    self.clubId = clubId
    self.clubName = clubName
    self.avgDist = avgDist
    self.perfContactPercentage = perfContactPercentage
    self.straightFlightPercentage = straightFlightPercentage
    self.expanded = false
  }
}
