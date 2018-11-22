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

  
  var yes = false

  override func viewDidLoad() {
        super.viewDidLoad()
        scorecardHole = 1

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
  


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
