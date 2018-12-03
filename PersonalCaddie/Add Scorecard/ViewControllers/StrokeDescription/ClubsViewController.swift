//
//  ClubsViewController.swift
//  PersonalCaddie
//
//  Created by Philip Baker on 11/13/18.
//  Copyright © 2018 67442. All rights reserved.
//

import UIKit

let clubs =
  [[
    "id": 1,
    "name": "Driver"
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
    "name": "PW"
    ],
   [
    "id": 11,
    "name": "AW"
    ],
   
   [
    "id": 12,
    "name": "60"
    ],
   [
    "id": 2,
    "name": "Putter"
    ]
]

class ClubsViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{

  
  @IBOutlet var collectionView: UICollectionView!

  
  var latitude: Double?
  var longitude: Double?
  
  
  let location = LocationManager()
  
  var selectedCellIndex: Int?
  
  
    override func viewDidLoad() {
        super.viewDidLoad()
      
      let nibCell = UINib(nibName: "ScorecardInputCollectionViewCell", bundle: nil)

      collectionView!.register(nibCell, forCellWithReuseIdentifier: "scorecardInputCell")

      collectionView.allowsMultipleSelection = false
      

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
      cell.backgroundColor = UIColor.green
    }

    cell.layer.borderWidth = 1
    cell.layer.borderColor = UIColor.black.cgColor
    cell.layer.cornerRadius = 10
    return cell
    
    
  }
  
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    // (self.navigationController as! StrokeInputNavigationViewController).scorecardHole =  clubs[indexPath.item]["id"] as! Int
    
    let cell = collectionView.cellForItem(at: indexPath) as! ScorecardInputCollectionViewCell
    selectedCellIndex = indexPath.item

    
    collectionView.reloadData()
    (self.navigationController as! StrokeInputNavigationViewController).club = clubs[selectedCellIndex!]["id"] as! Int
    
    self.performSegue(withIdentifier: "showLies", sender: collectionView)    
    
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    let width = collectionView.bounds.width / 2 - 6
    let height = collectionView.bounds.height / CGFloat(clubs.count/2) - 15
    
    if (clubs.count % 2 == 1 && indexPath.item == clubs.count-1){
      return CGSize(width: (width + 6) * 2 - 6 , height: height)
      
    }
    return CGSize(width: width , height: height)
  }
  
  // MARK: - IBActions
  
  @IBAction func cancelStroke(_ sender: UIButton){
    self.navigationController!.dismiss(animated: true)
  }

}
