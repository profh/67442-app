//
//  ScorecardDetailViewModel.swift
//  PersonalCaddie
//
//  Created by Philip Baker on 11/13/18.
//  Copyright © 2018 67442. All rights reserved.
//

import Foundation
import CoreLocation

class ScorecardDetailViewModel {
  
  var scorecardOverview: ScorecardOverview?
  var scorecard: ScorecardDetail?
  var networkClient: NetworkClient
  var parser: ScorecardParser
  
  var clubStats: [ClubStats] = []
  var strokes: [ReadStroke] = []

  
  init() {
    networkClient = NetworkClient()
    parser = ScorecardParser()
  }
  
  var numberOfHolesPlayed: Int{
    if let sc = scorecard{
      return sc.numHolesPlayed
    }
    return 0
  }
  
  func refreshScorecard(completion: @escaping () -> Void) {
    networkClient.fetchScorecardDetail({  data in
      if let scorecard = self.parser.parseScorecardDetailResponse(data!){
        self.scorecard = scorecard
      }
      
      completion()
      
    }, scorecardId: self.scorecardOverview!.scorecardId)
  }
  
  func refreshStats(completion: @escaping () -> Void ){
    networkClient.fetchStrokesForScorecard({data in

      if let strokes = self.parser.parseStrokesResponse(data!){
        self.strokes = strokes
        self.processStrokes()
        completion()
      }
      
    }, scorecardId: scorecardOverview!.scorecardId)
  }
  
  
  func refreshData(completion: @escaping () -> Void) {
    networkClient.fetchScorecardDetail({  data in
      if let scorecard = self.parser.parseScorecardDetailResponse(data!){
        self.scorecard = scorecard
      }
    }, scorecardId: self.scorecardOverview!.scorecardId)
    
    networkClient.fetchStrokesForScorecard({data in

      if let strokes = self.parser.parseStrokesResponse(data!){
        self.strokes = strokes
        self.processStrokes()
        completion()
      }
      
    }, scorecardId: scorecard!.scorecardId)
    
  }
  
  
  func processStrokes(){
    
    var clubStrokeLocations: [[[String: Double]]] = [[],[],[],[],[],[],[],[],[],[],[],[]]
    
    var next: ReadStroke
    var prev: ReadStroke = strokes.first!
    for s in strokes{
      if s.id != strokes.first!.id {
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
    
    
    var avgDistances: [Double] = []
    clubStrokeLocations[0].append(["latOne": Double(prev.lat)!, "lonOne": Double(prev.lon)!, "latTwo": 5.0, "lonTwo": 5.0])
    print(clubStrokeLocations[0])
    for club in clubStrokeLocations{
      if club.count > 0{
        let total = club.reduce(0.0) {total, d in total + CLLocation(latitude: d["latOne"]!, longitude: d["lonOne"]!).distance(from: CLLocation(latitude: d["latTwo"]!, longitude: d["lonTwo"]!))}
        print(total)
        avgDistances.append(total / Double(club.count))
      }
      else {
        print("here")
        avgDistances.append(0.0)
      }
    }
    
    print(avgDistances)
    
    //    var p1 = CLLocation(latitude: 0.0, longitude: 0.0)
    //    var p2 = CLLocation(latitude: 0.0, longitude: 0.0)
    //
    //    var total: Double = 0
    //    clubStrokeLocations[0].append(["latOne": Double(prev.lat)!, "lonOne": Double(prev.lon)!, "latTwo": 5.0, "lonTwo": 5.0])
    //    print(["latOne": Double(prev.lat)!, "lonOne": Double(prev.lon)!], "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!")
    //    for csl in clubStrokeLocations[0]{
    //      p1 = CLLocation(latitude: csl["latOne"]!, longitude: csl["lonOne"]!)
    //      p2 = CLLocation(latitude: csl["latTwo"]!, longitude: csl["lonTwo"]!)
    //      print(p1.distance(from: p2))
    //      total = total + p1.distance(from: p2)
    //    }
    //
    //    let a = clubStrokeLocations[0].reduce(0.0) {total, d in total + CLLocation(latitude: d["latOne"]!, longitude: d["lonOne"]!).distance(from: CLLocation(latitude: d["latTwo"]!, longitude: d["lonTwo"]!))}
    //
    //    print(total, a)
    //    print()
    //    print()
    //    print()
    //    print()
    //    print()
    //    print()
    //    print(total / Double(clubStrokeLocations[0].count))
    //
    
    
    
    for i in 0..<clubs.count{
      
      let clubStrokes = strokes.filter( { $0.club == clubs[i]["id"] as! Int})
      
      let perfContact = clubStrokes.filter( {
        if let ct = $0.contactType{
          return ct == "Perfect"
        }
        else {
          return false
        }
        
        }
      )
      
      let straightFlight = clubStrokes.filter( {
        if let ft = $0.flightType{
          return ft == "Straight"
        }
        else {
          return false
        }
        
        }
      )
      
      let numStrokes = Double(clubStrokes.count)
      if  numStrokes == 0.0 {
        clubStats.append(ClubStats(clubId: clubs[i]["id"] as! Int, clubName: clubs[i]["name"] as! String, avgDist: avgDistances[i], perfContactPercentage: nil, straightFlightPercentage: nil))
      }
      else {
        var pc = 0.0
        if perfContact.count > 0 {
          pc = Double(perfContact.count)
        }
        
        var sf = 0.0
        if straightFlight.count > 0{
          let sf = Double(straightFlight.count)
        }
        
        clubStats.append(ClubStats(clubId: clubs[i]["id"] as! Int, clubName: clubs[i]["name"] as! String, avgDist: avgDistances[i], perfContactPercentage: pc / numStrokes * 100, straightFlightPercentage: sf / numStrokes * 100))
        
        
      }
      
    }
  }
  
  
}
