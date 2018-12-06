//
//  ScorecardOverviewViewModel.swift
//  PersonalCaddie
//
//  Created by Philip Baker on 11/12/18.
//  Copyright © 2018 67442. All rights reserved.
//

import Foundation

class ScorecardOverviewViewModel {
  var parser: ScorecardParser
  var networkClient: NetworkClient
  var scorecards: [ScorecardOverview]
  init(){
    parser = ScorecardParser()
    networkClient = NetworkClient()
    scorecards = []
  }
  
  func refresh(completion: @escaping () -> Void) {
    networkClient.fetchScorecardOverviews{  data in

      if let scorecards = self.parser.parseScorecardOverviewResponse(data){
        self.scorecards = scorecards
        
      }
      completion()
      
    }
  }
  
  var numberOfScorecards: Int{
    return self.scorecards.count
  }
  
}
