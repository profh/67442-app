//
//  PlayerCardViewController.swift
//  PersonalCaddie
//
//  Created by Philip Baker on 12/3/18.
//  Copyright © 2018 67442. All rights reserved.
//

import UIKit

class PlayerCardViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
  
  @IBOutlet var collectionView: UICollectionView!
  var viewModel = PlayerCardViewModel()
  
  
    override func viewDidLoad() {
        super.viewDidLoad()
      viewModel.refresh (completion: { [unowned self] in
        DispatchQueue.main.async {
          self.collectionView.reloadData()
        }
        })

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
  
  
  
  // MARK: - Collection View
  
  func numberOfSections(in collectionView: UICollectionView) -> Int {
    return viewModel.clubStats.count
  }
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    if viewModel.clubStats[section].expanded {
      return 1
    }
    else {
      return 0
    }
    
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ClubStatsCell", for: indexPath) as! ClubStatsCollectionViewCell
    if let perfContactPercentage = viewModel.clubStats[indexPath.section].perfContactPercentage{
      cell.perfContactPercentage.text = "79.32 %" //String(format: "%.2f", perfContactPercentage) + " %"
    }
    else{
      cell.perfContactPercentage.text = "-"
    }
    
    cell.avgDistance.text = "164.5"
    cell.straightFlightPercentage.text = "71.45 %"
    
    
    cell.layer.borderWidth = 1
    cell.layer.borderColor = UIColor.black.cgColor
    return cell
  }
  
  func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {

    if let sectionHeader = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "SectionHeader", for: indexPath) as? SectionHeader{
      sectionHeader.sectionButton.setTitle(viewModel.clubStats[indexPath.section].clubName, for: .normal)
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
    
    viewModel.clubStats[indexPath.section].expanded = !viewModel.clubStats[indexPath.section].expanded
    
    let sections = IndexSet.init(integer: indexPath.section)
    collectionView.reloadSections(sections)
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


class SectionHeader: UICollectionReusableView {
  @IBOutlet weak var sectionHeaderlabel: UILabel!
  @IBOutlet weak var sectionButton: UIButton!
  
  var tapHeader: (() -> Void)?
  
  @IBAction func headerSelectedaaaaaa(sender: UIButton) {
    guard let tapHeader = tapHeader else {
      return
    }
    tapHeader()
    
  }
}
