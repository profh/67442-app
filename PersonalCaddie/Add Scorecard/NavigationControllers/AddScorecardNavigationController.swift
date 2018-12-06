//
//  AddScorecardViewController.swift
//  PersonalCaddie
//
//  Created by Philip Baker on 11/14/18.
//  Copyright © 2018 67442. All rights reserved.
//

import UIKit

class AddScorecardNavigationController: UINavigationController, UINavigationControllerDelegate {
  
  var currScorecard: Bool = false
  var viewModel = NewScorecardViewModel()
  
  override func viewDidLoad() {
      super.viewDidLoad()
  }

  override func didReceiveMemoryWarning() {
      super.didReceiveMemoryWarning()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    if currScorecard {
      let vc = self.viewControllers.last as! NewScorecardViewController
      vc.viewWillAppear(true)
    }
    if currScorecard && !(self.viewControllers.last is NewScorecardViewController)  {
      let vc:NewScorecardViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "NewScorecardViewController") as! NewScorecardViewController
      vc.viewModel = self.viewModel
      self.pushViewController(vc, animated: true)
    }
    else if currScorecard == false {
      let vc:ScorecardCourseViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ScorecardCourseViewController") as! ScorecardCourseViewController
      vc.viewModel = self.viewModel
      self.pushViewController(vc, animated: true)
    }
  }

}
