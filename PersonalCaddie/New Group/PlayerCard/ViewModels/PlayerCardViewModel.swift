//
//  PlayerCardViewModel.swift
//  PersonalCaddie
//
//  Created by Philip Baker on 12/3/18.
//  Copyright © 2018 67442. All rights reserved.
//

import Foundation
import CoreLocation


class PlayerCardViewModel: ProcessStrokes {
  let parser = PlayerCardParser()
  let networkClient = NetworkClient()
  var strokes: [ReadStroke]?
  var clubStats: [ClubStats] = []
  

  
  
  func refresh(completion: @escaping () -> Void ){
    networkClient.fetchStrokes({data in
      if let strokes = self.parser.parseStrokesResponse(data!){
        self.strokes = strokes
        self.clubStats = self.processStrokes(strokes)
        completion()
      }
    })
    
  }
  
  
  
  
}
