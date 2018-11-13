//
//  ScorecardDetailViewModel.swift
//  PersonalCaddie
//
//  Created by Philip Baker on 11/13/18.
//  Copyright © 2018 67442. All rights reserved.
//

import Foundation

class ScorecardDetailViewModel {
  
  var scorecardOverview: ScorecardOverview?
  var scorecard: ScorecardDetail?
  var networkClient: NetworkClient
  var parser: ScorecardParser
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
  
  func refresh(completion: @escaping () -> Void) {
    networkClient.fetchScorecardDetail({  data in

      if let scorecard = self.parser.parseScorecardDetailResponse(data!){
        self.scorecard = scorecard
        
      }
      
      completion()
      
    }, scorecardId: self.scorecardOverview!.scorecardId)
  }
}
