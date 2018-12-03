//
//  ClubStats.swift
//  PersonalCaddie
//
//  Created by Philip Baker on 12/3/18.
//  Copyright © 2018 67442. All rights reserved.
//

import Foundation


struct ClubStats {
  var clubName: String
  var perfContactPercentage: Double?
  var expanded: Bool
  
  init(clubName: String, perfContactPercentage: Double?){
    self.clubName = clubName
    self.perfContactPercentage = perfContactPercentage
    self.expanded = false
  }
}
