//
//  ScorecardDetailViewModel.swift
//  PersonalCaddie
//
//  Created by Philip Baker on 11/13/18.
//  Copyright © 2018 67442. All rights reserved.
//

import Foundation
import CoreLocation

class ScorecardDetailViewModel: ProcessStrokes{
  
  var scorecardOverview: ScorecardOverview
  var scorecard: ScorecardDetail?
  var networkClient: NetworkClient = NetworkClient()
  var parser: ScorecardParser = ScorecardParser()
  
  var clubStats: [ClubStats] = []
  var strokes: [ReadStroke] = []

  
  init(_ scorecardOverview: ScorecardOverview) {

    self.scorecardOverview = scorecardOverview
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
      
    }, scorecardId: self.scorecardOverview.scorecardId)
  }
  
  func refreshStats(completion: @escaping () -> Void ){
    networkClient.fetchStrokesForScorecard({data in

      if let strokes = self.parser.parseStrokesResponse(data!){
        self.strokes = strokes
        self.clubStats = self.processStrokes(strokes)
        completion()
      }
      
    }, scorecardId: scorecardOverview.scorecardId)
  }
  
  
  var numberOfClubStats: Int {
    return clubStats.count
  }
  
 

}
