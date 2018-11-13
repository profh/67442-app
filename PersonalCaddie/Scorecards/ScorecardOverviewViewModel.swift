//
//  ScorecardOverviewViewModel.swift
//  PersonalCaddie
//
//  Created by Philip Baker on 11/12/18.
//  Copyright © 2018 67442. All rights reserved.
//

import Foundation

class ScorecardOverviewViewModel {
  //var scorecards: [ScorecardOverview]
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
      
      // we need in this block a way for the parser to get an array of repository
      // objects (if they exist) and then set the repos var in the view model to
      // those repository objects
      
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
