//
//  AddScorecardViewController.swift
//  PersonalCaddie
//
//  Created by Philip Baker on 11/14/18.
//  Copyright © 2018 67442. All rights reserved.
//

import UIKit

class AddScorecardNavigationController: UINavigationController {
  
  var currScorecard: Bool = false

  override func viewDidLoad() {
      super.viewDidLoad()

      // Do any additional setup after loading the view.
  }

  override func didReceiveMemoryWarning() {
      super.didReceiveMemoryWarning()
      // Dispose of any resources that can be recreated.
  }
  
  
  override func viewWillAppear(_ animated: Bool) {
    if currScorecard {
      let vc:NewScorecardViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "NewScorecardViewController") as! NewScorecardViewController
      
      self.pushViewController(vc, animated: true)
    }
    else {
      let vc:ScorecardCourseViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ScorecardCourseViewController") as! ScorecardCourseViewController
      self.pushViewController(vc, animated: true)
    }
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
