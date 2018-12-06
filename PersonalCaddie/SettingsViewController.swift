//
//  SettingsViewController.swift
//  PersonalCaddie
//
//  Created by Philip Baker on 12/6/18.
//  Copyright © 2018 67442. All rights reserved.
//

import UIKit
import GoogleSignIn
class SettingsViewController: UIViewController, GIDSignInUIDelegate {

  @IBOutlet var logoutButton: UIButton!
  override func viewDidLoad() {
    super.viewDidLoad()
    logoutButton.layer.borderWidth = 1
    logoutButton.layer.cornerRadius = 10
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
  }
  
  
  @IBAction func signOut(_ sender: UIButton!)
  {
    GIDSignIn.sharedInstance().signOut()
    var token: String?
    let data = NSMutableData()
    let archiver = NSKeyedArchiver(forWritingWith: data)
    archiver.encode("", forKey: "token")
    archiver.finishEncoding()
    data.write(toFile: self.dataFilePath(), atomically: true)
    
    let storyboard = UIStoryboard(name: "Main", bundle: nil)
    let loginVc = storyboard.instantiateViewController(withIdentifier: "loginController") as! LoginViewController
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    appDelegate.window = UIWindow(frame: UIScreen.main.bounds)
    appDelegate.window?.rootViewController = loginVc
    appDelegate.window?.makeKeyAndVisible()
  }
  func documentsDirectory() -> String {
    let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
    return paths[0]
  }
  
  func dataFilePath() -> String {
    return documentsDirectory().stringByAppendingPathComponent(aPath: "UserInfo.plist")
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
