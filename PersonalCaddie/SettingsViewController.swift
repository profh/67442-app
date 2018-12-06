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
  @IBOutlet var trackingSaveButton: UIButton!

  @IBOutlet var clubTrackingSwitch: UISwitch!
  @IBOutlet var lieTrackingSwitch: UISwitch!
  @IBOutlet var contactTrackingSwitch: UISwitch!
  @IBOutlet var flightTrackingSwitch: UISwitch!
  
  var tracking: [String: Bool] = [:]
  var firstName: String = ""
  var lastName: String = ""
  var email: String = ""
  var token: String = ""
  
  override func viewDidLoad() {
    super.viewDidLoad()
    logoutButton.layer.borderWidth = 1
    logoutButton.layer.cornerRadius = 10
    trackingSaveButton.layer.borderWidth = 1
    trackingSaveButton.layer.cornerRadius = 10
    
    var clubTracking: Bool
    
    
    let path = self.dataFilePath()
    if FileManager.default.fileExists(atPath: path) {
      if let data = NSData(contentsOfFile: path) {
        let unarchiver = NSKeyedUnarchiver(forReadingWith: data as Data)
        
        firstName = unarchiver.decodeObject(forKey: "firstName") as! String
        lastName = unarchiver.decodeObject(forKey: "lastName") as! String
        email = unarchiver.decodeObject(forKey: "email") as! String
        token = unarchiver.decodeObject(forKey: "token") as! String
        tracking["clubTracking"] = unarchiver.decodeBool(forKey: "clubTracking")
        tracking["lieTracking"] = unarchiver.decodeBool(forKey: "lieTracking")
        tracking["contactTracking"] = unarchiver.decodeBool(forKey: "contactTracking")
        tracking["flightTracking"] = unarchiver.decodeBool(forKey: "flightTracking")
        
        unarchiver.finishDecoding()
        
        clubTrackingSwitch.isOn = tracking["clubTracking"]!
        lieTrackingSwitch.isOn = tracking["lieTracking"]!
        contactTrackingSwitch.isOn = tracking["contactTracking"]!
        flightTrackingSwitch.isOn = tracking["flightTracking"]!
        
      } else {
        print("\nFILE NOT FOUND AT: \(path)")
      }
      
      
    }

    
    
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


  
  @IBAction func switched(_ sender: UISwitch){
    tracking["clubTracking"] = clubTrackingSwitch.isOn
    tracking["lieTracking"] = lieTrackingSwitch.isOn
    tracking["contactTracking"] = contactTrackingSwitch.isOn
    tracking["flightTracking"] = flightTrackingSwitch.isOn
  }
  
  @IBAction func saveChanges(_ sender: UIButton){
    let data = NSMutableData()
    let archiver = NSKeyedArchiver(forWritingWith: data)
    archiver.encode(token, forKey: "token")
    archiver.encode(firstName, forKey: "firstName")
    archiver.encode(lastName, forKey: "lastName")
    archiver.encode(email, forKey: "email")
    archiver.encode(tracking["clubTracking"]!, forKey: "clubTracking")
    archiver.encode(tracking["lieTracking"]!, forKey: "lieTracking")
    archiver.encode(tracking["contactTracking"]!, forKey: "contactTracking")
    archiver.encode(tracking["flightTracking"]!, forKey: "flightTracking")
    archiver.finishEncoding()
    data.write(toFile: self.dataFilePath(), atomically: true)
  }

}
