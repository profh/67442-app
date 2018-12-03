//
//  ContactTypeViewController.swift
//  PersonalCaddie
//
//  Created by Philip Baker on 11/22/18.
//  Copyright © 2018 67442. All rights reserved.
//

import UIKit

let contactTypes = ["Perfect", "Fat", "Thin", "Top"]

class ContactTypeViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout  {
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
    return contactTypes.count
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "scorecardInputCell", for: indexPath) as! ScorecardInputCollectionViewCell
    
    cell.value.text = contactTypes[indexPath.row] as! String
    
    
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
    //    (self.navigationController as! StrokeInputNavigationViewController).scorecardHole =  clubs[indexPath.item]["id"] as! Int
    
    
    let cell = collectionView.cellForItem(at: indexPath) as! ScorecardInputCollectionViewCell
    selectedCellIndex = indexPath.item
    collectionView.reloadData()
    
    (self.navigationController as! StrokeInputNavigationViewController).contactType = contactTypes[indexPath.item]
    self.performSegue(withIdentifier: "showFlightType", sender: collectionView)
    
  }
  
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    let width = collectionView.bounds.width / 2 - 6
    let height = collectionView.bounds.height / CGFloat(contactTypes.count/2) - 15
    if (contactTypes.count % 2 == 1 && indexPath.item == contactTypes.count-1){
      return CGSize(width: (width + 6) * 2 - 6 , height: height)
      
    }
    return CGSize(width: width , height: height)
  }

  // MARK: - IBActions
  
  @IBAction func cancelStroke(_ sender: UIButton){
    self.navigationController!.dismiss(animated: true)
  }


}
