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
    
    // Do any additional setup after loading the view.
  }
  
  override func viewWillAppear(_ animated: Bool) {
    viewModel.refresh { [unowned self] in
      DispatchQueue.main.async {
        self.collectionView?.reloadData()
      }
    }
  }
  
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
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
  

  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if segue.identifier == "showCourseDetail" {
      if let indexPath = self.collectionView?.indexPathsForSelectedItems{
        (segue.destination as! CourseDetailViewController).viewModel = CourseDetailViewModel(viewModel.courseOverviews[indexPath[0].row])
        
        
        
      }
      
      
      
    }
  }
  
  
  
  

  
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
