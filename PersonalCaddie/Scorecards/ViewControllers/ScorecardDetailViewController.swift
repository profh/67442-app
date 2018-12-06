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
  @IBOutlet var clubStatsCollectionView: UICollectionView!

  var viewModel: ScorecardDetailViewModel?

  override func viewDidLoad() {
    super.viewDidLoad()

    collectionView.layer.borderWidth = 2
    collectionView.layer.borderColor = UIColor.black.cgColor

  }

  override func didReceiveMemoryWarning() {
      super.didReceiveMemoryWarning()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    let f = DateFormatter()
    f.dateFormat = "MM/dd/yy"

    self.viewModel!.refreshScorecard { [unowned self] in
      DispatchQueue.main.async {
        self.collectionView.reloadData()

      }
    }

    self.viewModel!.refreshStats(completion: { [unowned self] in
      DispatchQueue.main.async {
        self.clubStatsCollectionView.reloadData()

      }
    })
    
    
    if let scorecard = viewModel?.scorecardOverview{
      courseNameLabel.text = scorecard.courseName
      dateLabel.text = f.string(from: scorecard.date)
      pphLabel.text =  String(format: "%.2f", Double(scorecard.numPutts) / Double(scorecard.numHolesPlayed))
      scoreLabel.text = String(scorecard.numStrokes)
      parsLabel.text = String(scorecard.nineHolePar) + " / " + String(scorecard.eighteenHolePar)
    }
  }
  
  
  // MARK: - Collection View
  
  func numberOfSections(in collectionView: UICollectionView) -> Int {
    if collectionView == self.collectionView {
      return 1
    }
    else {
      return viewModel!.numberOfClubStats
    }
  }
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    if collectionView == self.collectionView{
      return viewModel!.numberOfHolesPlayed
    }
    else {
      if viewModel!.numberOfClubStats > 0 && viewModel!.clubStats[section].expanded {
        return 1
      }
      else {
        return 0
      }
    }
  }
  
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    if collectionView == self.collectionView {
      let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "scorecardHoleCell", for: indexPath) as! ScorecardHoleCell
      cell.num.text = String(viewModel!.scorecard!.scorecardHoles[indexPath.item].number)
      if (viewModel!.scorecard!.scorecardHoles[indexPath.item].numStrokes == 0){
        cell.score.text = "-"
      }
      else {
        cell.score.text = String(viewModel!.scorecard!.scorecardHoles[indexPath.item].numStrokes)
      }
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
    else if viewModel!.clubStats.count > 0{
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
    else {
      return UICollectionViewCell()
    }

  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
    if collectionView == self.collectionView{
      return 0
    }
    else {
      return 10
    }
  }
  
  
  func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
    if viewModel!.clubStats.count > 0 && collectionView == self.clubStatsCollectionView{
      if let sectionHeader = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "SectionHeader", for: indexPath) as? SectionHeader{
        sectionHeader.sectionButton.setTitle(viewModel!.clubStats[indexPath.section].clubName, for: .normal)
        sectionHeader.tapHeader = {self.tappedOnHeader(indexPath)}
        sectionHeader.sectionButton.layer.cornerRadius = 10
        sectionHeader.sectionButton.layer.borderWidth = 1
        sectionHeader.sectionButton.layer.borderColor = UIColor.black.cgColor
        return sectionHeader
      }
    }
    
    if collectionView == self.clubStatsCollectionView {
      if let sectionHeader = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "SectionHeader", for: indexPath) as? SectionHeader{
        return sectionHeader
      }
    }
    return UICollectionReusableView()
    
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    
    if collectionView == self.clubStatsCollectionView{
      return CGSize(width: collectionView.bounds.width - 20, height: 80)
    }
    else {
      return CGSize(width: 35.0, height: 160.0)
    }
  }

  
  func tappedOnHeader(_ indexPath: IndexPath) {
    
    viewModel!.clubStats[indexPath.section].expanded = !viewModel!.clubStats[indexPath.section].expanded
    
    let sections = IndexSet.init(integer: indexPath.section)
    clubStatsCollectionView.reloadSections(sections)
    if viewModel!.clubStats[indexPath.section].expanded {
      clubStatsCollectionView.scrollToItem(at: indexPath, at: .bottom, animated: true)
    }
  }
  
}



