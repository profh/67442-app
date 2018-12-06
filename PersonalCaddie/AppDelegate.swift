//
//  AppDelegate.swift
//  PersonalCaddie
//
//  Created by Philip Baker on 11/12/18.
//  Copyright © 2018 67442. All rights reserved.
//

import UIKit
import GoogleSignIn
import Alamofire
import SwiftyJSON

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, GIDSignInDelegate{

  var window: UIWindow?


  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
    // Override point for customization after application launch.
    UINavigationBar.appearance().tintColor = .black
    
    GIDSignIn.sharedInstance().clientID = "420746779112-kqupd99cd97ujpob7s6ofv867u2ohr60.apps.googleusercontent.com"
    GIDSignIn.sharedInstance().delegate = self
    
    var token: String = ""
    let path = self.dataFilePath()
    if FileManager.default.fileExists(atPath: path) {
      if let data = NSData(contentsOfFile: path) {
        let unarchiver = NSKeyedUnarchiver(forReadingWith: data as Data)
        token = unarchiver.decodeObject(forKey: "token") as! String
        unarchiver.finishDecoding()
      } else {
        print("\nFILE NOT FOUND AT: \(path)")
      }
    }
    let storyboard = UIStoryboard(name: "Main", bundle: nil)
    self.window = UIWindow(frame: UIScreen.main.bounds)
    var vc: UIViewController
    if token != "" {
      vc = storyboard.instantiateViewController(withIdentifier: "TabBarController") as! TabBarViewController
    }
    else {
      vc = storyboard.instantiateViewController(withIdentifier: "loginController") as UIViewController
    }
    self.window?.rootViewController = vc
    self.window?.makeKeyAndVisible()
    
    return true
  }

  
  func application(_ app: UIApplication, open url: URL, options: [UIApplicationOpenURLOptionsKey : Any] = [:]) -> Bool {
    return GIDSignIn.sharedInstance().handle(url as URL?,
                                             sourceApplication: options[UIApplicationOpenURLOptionsKey.sourceApplication] as? String,
                                             annotation: options[UIApplicationOpenURLOptionsKey.annotation])
  }
  
  
  func applicationWillResignActive(_ application: UIApplication) {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
  }

  func applicationDidEnterBackground(_ application: UIApplication) {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
  }

  func applicationWillEnterForeground(_ application: UIApplication) {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
  }

  func applicationDidBecomeActive(_ application: UIApplication) {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
  }

  func applicationWillTerminate(_ application: UIApplication) {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    // Saves changes in the application's managed object context before the application terminates.
  }
  
  
  // MARK: - Google Sign In
  
  func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!,
            withError error: Error!) {
    if let error = error {
      print("\(error.localizedDescription)")
    } else {
      let userId = user.userID                  // For client-side use only!
      let idToken: String = user.authentication.idToken // Safe to send to the server
      let fullName = user.profile.name
      let firstName: String = user.profile.givenName
      let lastName: String = user.profile.familyName
      let email: String = user.profile.email
      
      var token = ""
      Alamofire.request("https://personalcaddieapi.herokuapp.com/login/",method: .post, parameters: ["id_token": idToken], encoding: JSONEncoding.default).responseJSON{ response in
        do {
          if let swiftyjson = try? JSON(data: response.data! ){
            token = swiftyjson["token"].string!
            let data = NSMutableData()
            let archiver = NSKeyedArchiver(forWritingWith: data)
            archiver.encode(token, forKey: "token")
            archiver.encode(firstName, forKey: "firstName")
            archiver.encode(lastName, forKey: "lastName")
            archiver.encode(email, forKey: "email")
            archiver.finishEncoding()
            data.write(toFile: self.dataFilePath(), atomically: true)
          }
          print("Token as logging in:", token)
          if token != "" {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "TabBarController") as! TabBarViewController
            UIApplication.shared.keyWindow?.rootViewController!.present(vc, animated: true, completion: nil)
          }
        }
        catch {
          print("error serializing json: \(error)")
        }
      }
    }
  }
  
  // MARK: - Plist
  func documentsDirectory() -> String {
    let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
    return paths[0]
  }
  
  func dataFilePath() -> String {
    return documentsDirectory().stringByAppendingPathComponent(aPath: "UserInfo.plist")
  }
 
}



