//
//  Stroke.swift
//  PersonalCaddie
//
//  Created by Philip Baker on 11/15/18.
//  Copyright © 2018 67442. All rights reserved.
//

import Foundation


struct Stroke {
  let club: Int
  let lat: Double
  let lon: Double
  let contactType: String?
  let flightType: String?
  let finalLocation: String?

  init(club: Int, lat: Double, lon: Double, contactType: String?, flightType: String?, finalLocation: String?){
    
    self.club = club
    self.lat = lat
    self.lon = lon
    self.contactType = contactType
    self.flightType = flightType
    self.finalLocation = finalLocation
  }
}
