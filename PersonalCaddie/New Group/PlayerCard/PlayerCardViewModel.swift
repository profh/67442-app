//
//  PlayerCardViewModel.swift
//  PersonalCaddie
//
//  Created by Philip Baker on 12/3/18.
//  Copyright © 2018 67442. All rights reserved.
//

import Foundation
import CoreLocation


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
    
    var clubStrokeLocations: [[[String: Double]]] = [[],[],[],[],[],[],[],[],[],[],[],[]]
    
    var next: ReadStroke
    var prev: ReadStroke = strokes!.first!
    for s in strokes!{
      if s.id != strokes!.first!.id {
        if (prev.scorecardHole == s.scorecardHole){
          switch prev.club{
          case clubs[0]["id"] as! Int:
            clubStrokeLocations[0].append(["latOne": Double(prev.lat)!, "lonOne": Double(prev.lon)!, "latTwo": Double(s.lat)!, "lonTwo": Double(s.lon)!])
          case clubs[1]["id"] as! Int:
            clubStrokeLocations[1].append(["latOne": Double(prev.lat)!, "lonOne": Double(prev.lon)!, "latTwo": Double(s.lat)!, "lonTwo": Double(s.lon)!])
          case clubs[2]["id"] as! Int:
            clubStrokeLocations[2].append(["latOne": Double(prev.lat)!, "lonOne": Double(prev.lon)!, "latTwo": Double(s.lat)!, "lonTwo": Double(s.lon)!])
          case clubs[3]["id"] as! Int:
            clubStrokeLocations[3].append(["latOne": Double(prev.lat)!, "lonOne": Double(prev.lon)!, "latTwo": Double(s.lat)!, "lonTwo": Double(s.lon)!])
          case clubs[4]["id"] as! Int:
            clubStrokeLocations[4].append(["latOne": Double(prev.lat)!, "lonOne": Double(prev.lon)!, "latTwo": Double(s.lat)!, "lonTwo": Double(s.lon)!])
          case clubs[5]["id"] as! Int:
            clubStrokeLocations[5].append(["latOne": Double(prev.lat)!, "lonOne": Double(prev.lon)!, "latTwo": Double(s.lat)!, "lonTwo": Double(s.lon)!])
          case clubs[6]["id"] as! Int:
            clubStrokeLocations[6].append(["latOne": Double(prev.lat)!, "lonOne": Double(prev.lon)!, "latTwo": Double(s.lat)!, "lonTwo": Double(s.lon)!])
          case clubs[7]["id"] as! Int:
            clubStrokeLocations[7].append(["latOne": Double(prev.lat)!, "lonOne": Double(prev.lon)!, "latTwo": Double(s.lat)!, "lonTwo": Double(s.lon)!])
          case clubs[8]["id"] as! Int:
            clubStrokeLocations[8].append(["latOne": Double(prev.lat)!, "lonOne": Double(prev.lon)!, "latTwo": Double(s.lat)!, "lonTwo": Double(s.lon)!])
          case clubs[9]["id"] as! Int:
            clubStrokeLocations[9].append(["latOne": Double(prev.lat)!, "lonOne": Double(prev.lon)!, "latTwo": Double(s.lat)!, "lonTwo": Double(s.lon)!])
          case clubs[10]["id"] as! Int:
            clubStrokeLocations[10].append(["latOne": Double(prev.lat)!, "lonOne": Double(prev.lon)!, "latTwo": Double(s.lat)!, "lonTwo": Double(s.lon)!])
          case clubs[11]["id"] as! Int:
            clubStrokeLocations[11].append(["latOne": Double(prev.lat)!, "lonOne": Double(prev.lon)!, "latTwo": Double(s.lat)!, "lonTwo": Double(s.lon)!])
          case clubs[12]["id"] as! Int:
            clubStrokeLocations[12].append(["latOne": Double(prev.lat)!, "lonOne": Double(prev.lon)!, "latTwo": Double(s.lat)!, "lonTwo": Double(s.lon)!])
          default:
            print("Issue parsing")
          }
        }
      }
      prev = s
    }
    
    for csl in clubStrokeLocations{
        print(csl)
    }
    
    var p1 = CLLocation(latitude: 5.0, longitude: 5.0)
    var p2 = CLLocation(latitude: 5.0, longitude: 3.0)
    
    print(p1.distance(from: p2), "!!!!!!!!!!!!")
    
    
    
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
