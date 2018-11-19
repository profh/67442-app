//
//  ClubsViewController.swift
//  PersonalCaddie
//
//  Created by Philip Baker on 11/13/18.
//  Copyright © 2018 67442. All rights reserved.
//

import UIKit

class ClubsViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource{

  
  @IBOutlet var club: UILabel!
  @IBOutlet var collectionView: UICollectionView!
  @IBOutlet var lat: UILabel!
  @IBOutlet var lon: UILabel!
  
  var latitude: Double?
  var longitude: Double?
  
  
  let location = LocationManager()
  
  var selectedCellIndex: Int?
  
  let clubs =
    [[
      "id": 1,
      "name": "Driver"
  ],
  [
  "id": 2,
  "name": "Putter"
  ],
  [
  "id": 3,
  "name": "3 Wood"
  ],
  [
  "id": 4,
  "name": "4 Iron"
  ],
  [
  "id": 5,
  "name": "5 Iron"
  ],
  [
  "id": 6,
  "name": "6 Iron"
  ],
  [
  "id": 7,
  "name": "7 Iron"
  ],
  [
  "id": 8,
  "name": "8 Iron"
  ],
  [
  "id": 9,
  "name": "9 Iron"
  ],
  [
  "id": 10,
  "name": "Pitching Wedge"
  ],
  [
  "id": 11,
  "name": "Approach Wedge"
  ]]
    override func viewDidLoad() {
        super.viewDidLoad()
      
      let nibCell = UINib(nibName: "ScorecardInputCollectionViewCell", bundle: nil)

      collectionView!.register(nibCell, forCellWithReuseIdentifier: "scorecardInputCell")

      collectionView.allowsMultipleSelection = false
      
      
      let nav = (self.navigationController as! StrokeInputNavigationViewController)
      lat.text = String(nav.latitude!)
      lon.text = String(nav.longitude!)

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
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    // #warning Incomplete implementation, return the number of items
    return clubs.count
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "scorecardInputCell", for: indexPath) as! ScorecardInputCollectionViewCell
    
    cell.value.text = clubs[indexPath.row]["name"] as! String
    cell.club = clubs[indexPath.row]["id"] as! Int
    
    
    if selectedCellIndex != indexPath.row{
      cell.backgroundColor = UIColor.white
    }
    else {
      cell.backgroundColor = UIColor.blue
    }

    return cell
    
    
  }
  
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    (self.navigationController as! StrokeInputNavigationViewController).scorecardHole =  clubs[indexPath.item]["id"] as! Int
    club.text = String((self.navigationController as! StrokeInputNavigationViewController).scorecardHole!)
    
    
    let cell = collectionView.cellForItem(at: indexPath) as! ScorecardInputCollectionViewCell
    cell.backgroundColor = UIColor.blue
    selectedCellIndex = indexPath.item
    
    collectionView.reloadData()
    
  }
  
  
  @IBAction func submit(_ sender: UIButton) {
    if let clubId = selectedCellIndex,
      let lat = (self.navigationController as! StrokeInputNavigationViewController).latitude,
      let lon = (self.navigationController as! StrokeInputNavigationViewController).longitude
      {
      (self.navigationController! as! StrokeInputNavigationViewController).viewModel!.strokes.append(Stroke(club: clubId, lat: lat, lon: lon, contactType: nil, flightType: nil, finalLocation: nil))
      self.navigationController!.dismiss(animated: true)
    }
  }

}
