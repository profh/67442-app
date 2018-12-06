//
//  CourseOverviewViewController.swift
//  PersonalCaddie
//
//  Created by Philip Baker on 11/28/18.
//  Copyright © 2018 67442. All rights reserved.
//

import UIKit

class CourseOverviewViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout{
  
  let viewModel = CourseOverviewViewModel()
  
  override func viewDidLoad() {
    super.viewDidLoad()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    viewModel.refresh { [unowned self] in
      DispatchQueue.main.async {
        
        if self.viewModel.numberOfCourseOverviews != 0{
          self.collectionView?.reloadData()
        }
        else{
          let frame = CGRect(x: self.view.bounds.size.width/10 * 2, y: self.view.bounds.size.height/4, width: self.view.bounds.size.width/10 * 6, height: self.view.bounds.size.height/2) // x , y, width , height
          
          let lbl = UILabel(frame: frame)
          
          lbl.textAlignment = .center //For center alignment
          lbl.text = "You haven't played a round yet!\n \n  Check back after you've played a few rounds "
          lbl.textColor = .black
          lbl.font = UIFont.systemFont(ofSize: 25)
          lbl.numberOfLines = 0
          lbl.lineBreakMode = .byWordWrapping
          
          lbl.sizeToFit()//If required
          self.view.addSubview(lbl)
        }
      }
    }
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
  }
  
  // MARK: - CollectionView
  
  override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return viewModel.numberOfCourseOverviews
  }
  
  override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CourseOverviewCell", for: indexPath) as! CourseOverviewCollectionViewCell
    let courseOverview = viewModel.courseOverviews[indexPath.item]
    
    cell.name.text = courseOverview.name
    cell.numScorecards.text = String(courseOverview.numScorecards)
    if courseOverview.numHolesPlayed == 0 {
      cell.puttsPerHole.text = "0"
    }
    else {
      cell.puttsPerHole.text = String(format: "%.2f", Double(courseOverview.numPutts) / Double(courseOverview.numHolesPlayed))
    }
    cell.par.text = String(courseOverview.nineHolePar) + "/" + String(courseOverview.eighteenHolePar)
    
    cell.layer.borderColor = UIColor.black.cgColor
    cell.layer.borderWidth = 1
    cell.layer.cornerRadius = 10
    
    return cell
  }
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    
    return CGSize(width: self.view.frame.width - 10, height: 110)
  }
  
  // MARK: - Navigation

  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if segue.identifier == "showCourseDetail" {
      if let indexPath = self.collectionView?.indexPathsForSelectedItems{
        (segue.destination as! CourseDetailViewController).viewModel = CourseDetailViewModel(viewModel.courseOverviews[indexPath[0].row])

      }

    }
  }

}
