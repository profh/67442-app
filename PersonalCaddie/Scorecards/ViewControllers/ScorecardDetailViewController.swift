//
//  ScorecardDetailViewController.swift
//  PersonalCaddie
//
//  Created by Philip Baker on 11/12/18.
//  Copyright © 2018 67442. All rights reserved.
//

import UIKit

class ScorecardDetailViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
  
  @IBOutlet var courseNameLabel: UILabel!
  @IBOutlet var dateLabel: UILabel!
  @IBOutlet var scoreLabel: UILabel!
  @IBOutlet var pphLabel: UILabel!
  @IBOutlet var parsLabel: UILabel!
  
  @IBOutlet var collectionView: UICollectionView!
  var viewModel: ScorecardDetailViewModel?

    override func viewDidLoad() {
      super.viewDidLoad()

      viewModel!.refresh { [unowned self] in
        DispatchQueue.main.async {
          self.collectionView.reloadData()
        }
      }
      collectionView.layer.borderWidth = 2
      collectionView.layer.borderColor = UIColor.black.cgColor
      
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    let f = DateFormatter()
    f.dateFormat = "MM/dd/yy"
    
    if let scorecard = viewModel?.scorecardOverview{
      courseNameLabel.text = scorecard.courseName
      dateLabel.text = f.string(from: scorecard.date)
      pphLabel.text = String(scorecard.numPutts)
      scoreLabel.text = String(scorecard.numStrokes)
      parsLabel.text = String(scorecard.nineHolePar) + " / " + String(scorecard.eighteenHolePar)
    }
  }
  
  
  // MARK: - Collection View
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return viewModel!.numberOfHolesPlayed
  }
  
  
  
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "scorecardHoleCell", for: indexPath) as! ScorecardHoleCell
    cell.num.text = String(viewModel!.scorecard!.scorecardHoles[indexPath.item].number)
    cell.score.text = String(viewModel!.scorecard!.scorecardHoles[indexPath.item].numStrokes)
    cell.par.text = String(viewModel!.scorecard!.scorecardHoles[indexPath.item].par)
    cell.dist.text = String(viewModel!.scorecard!.scorecardHoles[indexPath.item].distance )
    
    cell.layer.borderWidth = 1
    cell.layer.borderColor = UIColor.black.cgColor
    cell.num.layer.borderWidth = 1
    cell.num.layer.borderColor = UIColor.black.cgColor
    cell.score.layer.borderWidth = 1
    cell.score.layer.borderColor = UIColor.black.cgColor
    cell.par.layer.borderWidth = 1
    cell.par.layer.borderColor = UIColor.black.cgColor
    cell.dist.layer.borderWidth = 1
    cell.dist.layer.borderColor = UIColor.black.cgColor
    return cell
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
    return 0
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
