//
//  CourseDetailViewController.swift
//  PersonalCaddie
//
//  Created by Philip Baker on 11/30/18.
//  Copyright © 2018 67442. All rights reserved.
//

import UIKit

class CourseDetailViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{

  var viewModel: CourseDetailViewModel?
  @IBOutlet var courseName: UILabel!
  @IBOutlet var addressOne: UILabel!
  @IBOutlet var addressTwo: UILabel!
  @IBOutlet var numScorecards: UILabel!
  @IBOutlet var pars: UILabel!
  @IBOutlet var puttsPerHole: UILabel!
  
  @IBOutlet var collectionView: UICollectionView!
  
  
  
  override func viewDidLoad() {
      super.viewDidLoad()
    if let vm = viewModel{
      let course  = vm.course
      courseName.text = course.name
      addressOne.text = course.street
      addressTwo.text = course.city + ", " + course.state + " " + course.zip_code
      numScorecards.text = String(course.numScorecards)
      puttsPerHole.text =  String(format: "%.2f", Double(course.numPutts) / Double(course.numHolesPlayed))
      pars.text = String(course.nineHolePar) + "/" + String(course.eighteenHolePar)
      
    }
    

  }

  override func didReceiveMemoryWarning() {
      super.didReceiveMemoryWarning()
  }
  
  override func viewWillAppear(_ animated: Bool){
    if let vm = viewModel{
      vm.refresh(completion: { [unowned self] in
        DispatchQueue.main.async {
          self.collectionView.reloadData()
        }
      })
    }
  }

  
  // MARK: - Collection View
  
  func numberOfSections(in collectionView: UICollectionView) -> Int {
    return viewModel!.numClubStats
  }
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {

    if viewModel!.clubStats[section].expanded {
      return 1
    }
    else {
      return 0
    }
    
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ClubStatsCell", for: indexPath) as! ClubStatsCollectionViewCell
    if let avgDist = viewModel!.clubStats[indexPath.section].avgDist{
      cell.avgDistance.text = String(format: "%.2f", avgDist)
    }
    else{
      cell.avgDistance.text = "-"
    }
    
    if let perfContactPercentage = viewModel!.clubStats[indexPath.section].perfContactPercentage{
      cell.perfContactPercentage.text = String(format: "%.2f", perfContactPercentage) + " %"
    }
    else{
      cell.perfContactPercentage.text = "-"
    }
    
    if let straightFlightPercentage = viewModel!.clubStats[indexPath.section].straightFlightPercentage{
      cell.straightFlightPercentage.text = String(format: "%.2f", straightFlightPercentage)
    }
    else{
      cell.straightFlightPercentage.text = "-"
    }
    
    cell.layer.borderWidth = 1
    cell.layer.borderColor = UIColor.black.cgColor
    return cell
  }
  
  func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
    
    if let sectionHeader = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "SectionHeader", for: indexPath) as? SectionHeader{
      sectionHeader.sectionButton.setTitle(viewModel!.clubStats[indexPath.section].clubName, for: .normal)
      sectionHeader.tapHeader = {self.tappedOnHeader(indexPath)}
      
      sectionHeader.sectionButton.layer.cornerRadius = 10
      sectionHeader.sectionButton.layer.borderWidth = 1
      sectionHeader.sectionButton.layer.borderColor = UIColor.black.cgColor
      return sectionHeader
    }
    
    return UICollectionReusableView()
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    
    return CGSize(width: collectionView.bounds.width - 20, height: 80)
  }
  
  
  func tappedOnHeader(_ indexPath: IndexPath) {
    
    viewModel!.clubStats[indexPath.section].expanded = !viewModel!.clubStats[indexPath.section].expanded
    
    let sections = IndexSet.init(integer: indexPath.section)
    collectionView.reloadSections(sections)
    if viewModel!.clubStats[indexPath.section].expanded {
      collectionView.scrollToItem(at: indexPath, at: .bottom, animated: true)
    }
  }


}
