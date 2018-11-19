//
//  NewScorecardViewModel.swift
//  PersonalCaddie
//
//  Created by Philip Baker on 11/14/18.
//  Copyright © 2018 67442. All rights reserved.
//

import Foundation

class NewScorecardViewModel {
  
  let networkClient: NetworkClient
  let parser: AddScorecardParser
  var holes: [Hole]
  var course: Course?
  
  var holesPlayed: [[Stroke]]
  var strokes: [Stroke]
  
  init(){
    networkClient = NetworkClient()
    parser = AddScorecardParser()
    holes = []
    strokes = [] //[Stroke(club: 1, lat: 3.234, lon: 23.234, contactType: nil, flightType: nil, finalLocation: nil),Stroke(club: 5, lat: 3.234, lon: 23.234, contactType: nil, flightType: nil, finalLocation: nil),Stroke(club: 2, lat: 3.234, lon: 23.234, contactType: nil, flightType: nil, finalLocation: nil)]
    holesPlayed = []
    
  }
  
  func refresh(completion: @escaping () -> Void, courseId: Int) {
    networkClient.fetchHoles({  data in
      
      if let holes = self.parser.parseHolesResponse(data){
        self.holes = holes
      }
      completion()
      
    }, courseId: courseId)
  }
  
  var numberOfHoles: Int{
    return self.holes.count
  }
  

}
