//
//  FlightTypeViewController.swift
//  PersonalCaddie
//
//  Created by Philip Baker on 11/21/18.
//  Copyright © 2018 67442. All rights reserved.
//

import UIKit



class FlightTypeViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

  
  @IBOutlet var collectionView: UICollectionView!
  @IBOutlet var submitButton: UIButton!
  var selectedCellIndex: Int?

  override func viewDidLoad() {
      super.viewDidLoad()
    let nibCell = UINib(nibName: "ScorecardInputCollectionViewCell", bundle: nil)
    
    collectionView!.register(nibCell, forCellWithReuseIdentifier: "scorecardInputCell")
    
    submitButton.isEnabled = false
    submitButton.layer.borderColor = UIColor.gray.cgColor
    submitButton.layer.borderWidth = 1
    submitButton.layer.cornerRadius = 10
    submitButton.setTitleColor(UIColor.black, for: .normal)
    submitButton.setTitleColor(UIColor.gray, for: .disabled)
  }

  override func didReceiveMemoryWarning() {
      super.didReceiveMemoryWarning()
  }
  
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
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
    
    cell.layer.borderWidth = 1
    cell.layer.borderColor = UIColor.black.cgColor
    cell.layer.cornerRadius = 10
    
    return cell
    
    
  }
  
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    
    submitButton.isEnabled = true
    submitButton.layer.borderColor = UIColor.black.cgColor

    let cell = collectionView.cellForItem(at: indexPath) as! ScorecardInputCollectionViewCell
    selectedCellIndex = indexPath.item
    collectionView.reloadData()
    
    (self.navigationController as! StrokeInputNavigationViewController).flightType = flightTypes[indexPath.item]

  }
  
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    let width = collectionView.bounds.width / 2 - 6
    let height = collectionView.bounds.height / CGFloat((flightTypes.count+1)/2) - 15
    
    if (flightTypes.count % 2 == 1 && indexPath.item == flightTypes.count-1){
      return CGSize(width: (width + 6) * 2 - 6 , height: height)
      
    }
    return CGSize(width: width , height: height)
  }

  // MARK: - IBActions
  
  @IBAction func cancelStroke(_ sender: UIButton){
    self.navigationController!.dismiss(animated: true)
  }
  
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
    }
  }
  
  

}
