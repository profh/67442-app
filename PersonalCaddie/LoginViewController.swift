//
//  LoginViewController.swift
//  PersonalCaddie
//
//  Created by Philip Baker on 12/6/18.
//  Copyright © 2018 67442. All rights reserved.
//

import UIKit
import GoogleSignIn


class LoginViewController: UIViewController, GIDSignInUIDelegate  {

  override func viewDidLoad() {
    super.viewDidLoad()
    GIDSignIn.sharedInstance().uiDelegate = self
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
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
