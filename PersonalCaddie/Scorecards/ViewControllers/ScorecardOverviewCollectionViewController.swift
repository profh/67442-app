//
//  ScorecardOverviewCollectionViewController.swift
//  PersonalCaddie
//
//  Created by Philip Baker on 11/12/18.
//  Copyright © 2018 67442. All rights reserved.
//

import UIKit

private let reuseIdentifier = "scorecardOverviewCell"

class ScorecardOverviewCollectionViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
  var viewModel = ScorecardOverviewViewModel()

  override func viewDidLoad() {
    super.viewDidLoad()
    let nibCell = UINib(nibName: "ScorecardOverviewCollectionViewCell", bundle: nil)
    collectionView!.register(nibCell, forCellWithReuseIdentifier: reuseIdentifier)
    
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
  }

  // MARK: - UICollectionView

  override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
      return viewModel.numberOfScorecards
  }

  override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! ScorecardOverviewCollectionViewCell
  
    let f = DateFormatter()
    f.dateFormat = "MM/dd/yy"
    let numScorecards = viewModel.numberOfScorecards
    let scorecard = viewModel.scorecards[numScorecards - indexPath.row - 1]
    
    cell.courseNameLabel.text = scorecard.courseName
    cell.dateLabel.text = f.string(from: scorecard.date)
    cell.holesPlayedLabel.text = String(scorecard.numHolesPlayed)
    cell.scoreLabel.text = String(scorecard.numStrokes)
    if scorecard.numHolesPlayed == 0 {
      cell.puttsPerHoleLabel.text = "0"
    }
    else {
      cell.puttsPerHoleLabel.text = String(format: "%.2f", Double(scorecard.numPutts) / Double(scorecard.numHolesPlayed))
    }
    
    cell.pars.text = String(scorecard.nineHolePar) + " / " + String(scorecard.eighteenHolePar)
    
    cell.layer.borderColor = UIColor.black.cgColor
    cell.layer.borderWidth = 1
    cell.layer.cornerRadius = 10
    
    return cell

  }

  override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    self.performSegue(withIdentifier: "showScorecardDetail", sender: collectionView)
  }

  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    
    return CGSize(width: self.view.frame.width - 10, height: 110)
  }
  
  // MARK: - Navigation:
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if segue.identifier == "showScorecardDetail" {
      if let indexPath = self.collectionView?.indexPathsForSelectedItems{
        (segue.destination as! ScorecardDetailViewController).viewModel = ScorecardDetailViewModel(viewModel.scorecards[viewModel.numberOfScorecards - indexPath[0].row - 1])
      }
      
    }
  }
}
