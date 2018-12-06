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
  
  
  var clubTracking = true
  var lieTracking = true
  var contactTracking = true
  var flightTracking = true
  
  var viewModel: NewScorecardViewModel?

  override func viewDidLoad() {
    super.viewDidLoad()
    let path = self.dataFilePath()
    if FileManager.default.fileExists(atPath: path) {
      if let data = NSData(contentsOfFile: path) {
        let unarchiver = NSKeyedUnarchiver(forReadingWith: data as Data)
        
        
        clubTracking = unarchiver.decodeBool(forKey: "clubTracking")
        lieTracking = unarchiver.decodeBool(forKey: "lieTracking")
        contactTracking = unarchiver.decodeBool(forKey: "contactTracking")
        flightTracking = unarchiver.decodeBool(forKey: "flightTracking")
        
        unarchiver.finishDecoding()
        
        
      } else {
        print("\nFILE NOT FOUND AT: \(path)")
      }
      
      
    }
    var vc: UIViewController
    
    // club is required. uncomment this and adjust api to make club optional
//    if clubTracking{
//      vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "clubVC") as! ClubsViewController
//    }
//    else if lieTracking {
//      vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "lieVC") as! LieViewController
//    }
//    else if contactTracking {
//      vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "contactVC") as! ContactTypeViewController
//    }
//    else if flightTracking {
//      vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "flightVC") as! FlightTypeViewController
//    }
//    else {
//      vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "SubmitStrokeVC") as! SubmitStrokeViewController
//    }
    vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "clubVC") as! ClubsViewController

    self.pushViewController(vc, animated: true)

    
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
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
