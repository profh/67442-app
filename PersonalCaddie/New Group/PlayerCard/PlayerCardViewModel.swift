//
//  PlayerCardViewModel.swift
//  PersonalCaddie
//
//  Created by Philip Baker on 12/3/18.
//  Copyright © 2018 67442. All rights reserved.
//

import Foundation


class PlayerCardViewModel {
  let parser = PlayerCardParser()
  let networkClient = NetworkClient()
  var strokes: [ReadStroke]?
  var clubStats: [ClubStats]
  
  
  init() {
    clubStats = []
  }
  
  
  func refresh(completion: @escaping () -> Void ){
    networkClient.fetchStrokes({data in
      if let strokes = self.parser.parseStrokesResponse(data!){
        self.strokes = strokes
        self.processStrokes()
        completion()
      }
    })
    
  }
  
  
  func processStrokes(){
    for club in clubs{
      let clubStrokes = strokes!.filter( { $0.club == club["id"] as! Int})
      let perfContact = clubStrokes.filter( {
      if let ct = $0.contactType{
        return ct == "Perfect"
        }
      else {
        return false
        }
        
      })
      
      if clubStrokes.count == 0 {
        clubStats.append(ClubStats(clubName: club["name"] as! String, perfContactPercentage: nil))
      }
      else if perfContact.count == 0 {
        clubStats.append(ClubStats(clubName: club["name"] as! String, perfContactPercentage: 0.0))
      }
      else {
        clubStats.append(ClubStats(clubName: club["name"] as! String, perfContactPercentage: Double(perfContact.count) / Double(clubStrokes.count) * 100))
      }
    }
  }
  
}
