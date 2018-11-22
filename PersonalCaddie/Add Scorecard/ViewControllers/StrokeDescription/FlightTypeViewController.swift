//
//  FlightTypeViewController.swift
//  PersonalCaddie
//
//  Created by Philip Baker on 11/21/18.
//  Copyright © 2018 67442. All rights reserved.
//

import UIKit


let flightTypes = ["Draw", "Fade", "Push", "Pull", "Slice", "Hook", "Straight"]

class FlightTypeViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {

  
  @IBOutlet var collectionView: UICollectionView!
  var selectedCellIndex: Int?

  override func viewDidLoad() {
      super.viewDidLoad()
    let nibCell = UINib(nibName: "ScorecardInputCollectionViewCell", bundle: nil)
    
    collectionView!.register(nibCell, forCellWithReuseIdentifier: "scorecardInputCell")

      // Do any additional setup after loading the view.
  }

  override func didReceiveMemoryWarning() {
      super.didReceiveMemoryWarning()
      // Dispose of any resources that can be recreated.
  }
  
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    // #warning Incomplete implementation, return the number of items
    return flightTypes.count
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "scorecardInputCell", for: indexPath) as! ScorecardInputCollectionViewCell
    
    cell.value.text = flightTypes[indexPath.row] as! String
    
    
    if selectedCellIndex != indexPath.row{
      cell.backgroundColor = UIColor.white
    }
    else {
      cell.backgroundColor = UIColor.green
    }
    
    return cell
    
    
  }
  
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//    (self.navigationController as! StrokeInputNavigationViewController).scorecardHole =  clubs[indexPath.item]["id"] as! Int
    
    
    let cell = collectionView.cellForItem(at: indexPath) as! ScorecardInputCollectionViewCell
    selectedCellIndex = indexPath.item
    collectionView.reloadData()
    
    (self.navigationController as! StrokeInputNavigationViewController).flightType = flightTypes[indexPath.item]

  }

  /*
  // MARK: - Navigation

  // In a storyboard-based application, you will often want to do a little preparation before navigation
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
      // Get the new view controller using segue.destinationViewController.
      // Pass the selected object to the new view controller.
  }
  */

  
  @IBAction func submit(_ sender: UIButton) {
    if let clubId = (self.navigationController as! StrokeInputNavigationViewController).club,
      let lon = (self.navigationController as! StrokeInputNavigationViewController).longitude,
      let lat = (self.navigationController as! StrokeInputNavigationViewController).latitude,
      let ct = (self.navigationController as! StrokeInputNavigationViewController).contactType,
      let ft = (self.navigationController as! StrokeInputNavigationViewController).flightType,
      let lie = (self.navigationController as! StrokeInputNavigationViewController).lie
    {
      (self.navigationController! as! StrokeInputNavigationViewController).viewModel!.strokes.append(Stroke(club: clubId, lat: lat, lon: lon, contactType: ct, flightType: ft, finalLocation: lie))
      self.navigationController!.dismiss(animated: true)
      print(Stroke(club: clubId, lat: lat, lon: lon, contactType: ct, flightType: ft, finalLocation: lie))
    }
  }

}
