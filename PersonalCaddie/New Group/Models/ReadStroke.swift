//
//  Stroke.swift
//  PersonalCaddie
//
//  Created by Philip Baker on 11/30/18.
//  Copyright © 2018 67442. All rights reserved.
//

import Foundation

class ReadStroke {
  var id: Int
  var scorecardHole: Int
  var club: Int
  var lat: String
  var lon: String
  var contactType: String?
  var flightType: String?
  var lie: String?
  
  init(id: Int, scorecardHole: Int, club: Int, lat: String, lon: String, contactType: String?, flightType: String?, lie: String?){
    self.id = id
    self.scorecardHole = scorecardHole
    self.club = club
    self.lat = lat
    self.lon = lon
    self.contactType = contactType
    self.flightType = flightType
    self.lie = lie
  }
}
