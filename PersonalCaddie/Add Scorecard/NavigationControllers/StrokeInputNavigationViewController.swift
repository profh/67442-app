//
//  StrokeInputNavigationViewController.swift
//  PersonalCaddie
//
//  Created by Philip Baker on 11/13/18.
//  Copyright © 2018 67442. All rights reserved.
//

import UIKit
import CoreLocation

class StrokeInputNavigationViewController: UINavigationController {

  var scorecardHole: Int?
  var latitude: Double?
  var longitude: Double?
  var club: Int?
  var flightType: String?
  var lie: String?
  var contactType: String?
  
  var viewModel: NewScorecardViewModel?

  override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}
