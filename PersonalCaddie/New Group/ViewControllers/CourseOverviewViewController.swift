//
//  CourseOverviewViewController.swift
//  PersonalCaddie
//
//  Created by Philip Baker on 11/28/18.
//  Copyright © 2018 67442. All rights reserved.
//

import UIKit

class CourseOverviewViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
  
  let viewModel = CourseOverviewViewModel()
  @IBOutlet var collectionView: UICollectionView!
  
  
  
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
  
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return viewModel.numberOfCourseOverviews
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CourseOverviewCell", for: indexPath) as! CourseOverviewCollectionViewCell
    let courseOverview = viewModel.courseOverviews[indexPath.item]
    
    cell.name.text = courseOverview.name
    cell.numScorecards.text = String(courseOverview.numScorecards)
    cell.puttsPerHole.text = String(Double(courseOverview.numPutts) / Double(courseOverview.numHolesPlayed))
    cell.par.text = String(courseOverview.nineHolePar) + "/" + String(courseOverview.eighteenHolePar)
    
    
    
    return cell
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
