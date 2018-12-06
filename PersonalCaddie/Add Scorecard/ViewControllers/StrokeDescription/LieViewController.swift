//
//  LieViewController.swift
//  PersonalCaddie
//
//  Created by Philip Baker on 11/21/18.
//  Copyright © 2018 67442. All rights reserved.
//

import UIKit



class LieViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
  
  
  @IBOutlet var collectionView: UICollectionView!
  var selectedCellIndex: Int?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    let nibCell = UINib(nibName: "ScorecardInputCollectionViewCell", bundle: nil)
    
    collectionView!.register(nibCell, forCellWithReuseIdentifier: "scorecardInputCell")
    
    let cancel = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelStroke))
    cancel.tintColor = UIColor.red
    self.navigationItem.rightBarButtonItems = [cancel]
    self.navigationItem.title = "Lie"
  }

  override func didReceiveMemoryWarning() {
      super.didReceiveMemoryWarning()
  }
  
  // MARK: - Collection View
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return lies.count
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "scorecardInputCell", for: indexPath) as! ScorecardInputCollectionViewCell
    
    cell.value.text = lies[indexPath.row] as! String
    
    
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
    
    let cell = collectionView.cellForItem(at: indexPath) as! ScorecardInputCollectionViewCell
    selectedCellIndex = indexPath.item
    collectionView.reloadData()
    
    let navVC = (self.navigationController as! StrokeInputNavigationViewController)
    navVC.lie = lies[indexPath.item]
    
    var vc: UIViewController
    if navVC.contactTracking {
      vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "contactVC") as! ContactTypeViewController
    }
    else if navVC.flightTracking {
      vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "flightVC") as! FlightTypeViewController
    }
    else {
      vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "SubmitStrokeVC") as! SubmitStrokeViewController
    }
    navVC.pushViewController(vc, animated: true)
  }
  
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    let width = collectionView.bounds.width / 2 - 6
    let height = collectionView.bounds.height / CGFloat(lies.count/2) - 15
    if (lies.count % 2 == 1 && indexPath.item == lies.count-1){
      return CGSize(width: (width + 6) * 2 - 6 , height: height)

    }
    return CGSize(width: width , height: height)
  }
  
  // MARK: - IBActions
  
  @IBAction func cancelStroke(_ sender: UIButton){
    self.navigationController!.dismiss(animated: true)
  }

   

}
