//
//  NewScorecardViewController.swift
//  PersonalCaddie
//
//  Created by Philip Baker on 11/14/18.
//  Copyright © 2018 67442. All rights reserved.
//

import UIKit



class NewScorecardViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UITableViewDataSource, UITableViewDelegate, UICollectionViewDelegateFlowLayout {

  var viewModel: NewScorecardViewModel?
  @IBOutlet var courseNameLabel: UILabel!
  @IBOutlet var collectionView: UICollectionView!
  @IBOutlet var tableView: UITableView!
  
  @IBOutlet var newStrokeButton: UIButton!
  @IBOutlet var holeButton: UIButton!
  @IBOutlet var completeScorecardButton: UIButton!
  
  
  var location: LocationManager = LocationManager()

  var inHole = false


  override func viewDidLoad() {
    super.viewDidLoad()

    courseNameLabel.text = viewModel!.course!.name
    
    viewModel!.refresh (completion: { [unowned self] in
      DispatchQueue.main.async {
        
        self.collectionView.reloadData()
      }
    }, courseId: viewModel!.course!.courseId)
    if !inHole {
      newStrokeButton.isEnabled = false
      newStrokeButton.layer.borderColor = UIColor.gray.cgColor
      
      completeScorecardButton.layer.borderColor = UIColor.black.cgColor
    }
    else {
      newStrokeButton.isEnabled = true
      newStrokeButton.layer.borderColor = UIColor.black.cgColor
      completeScorecardButton.isEnabled = false
      completeScorecardButton.layer.borderColor = UIColor.gray.cgColor
    }
    newStrokeButton.setTitleColor(UIColor.black, for: .normal)
    newStrokeButton.setTitleColor(UIColor.gray, for: .disabled)
    newStrokeButton.layer.borderWidth = 1
    newStrokeButton.layer.cornerRadius = 10
    
    completeScorecardButton.setTitleColor(UIColor.black, for: .normal)
    completeScorecardButton.setTitleColor(UIColor.gray, for: .disabled)
    completeScorecardButton.layer.borderWidth = 1
    completeScorecardButton.layer.cornerRadius = 10
    
    holeButton.layer.borderWidth = 1
    holeButton.layer.cornerRadius = 10
    holeButton.setTitleColor(UIColor.black, for: .normal)
    
    
    let holeNum = viewModel!.numberOfHolesPlayed + 1
    let title = "Start Hole #\(holeNum)"
    holeButton.setTitle(title, for: .normal)

    collectionView.layer.borderWidth = 2
    collectionView.layer.borderColor = UIColor.black.cgColor
    
  }
  
  override func viewWillAppear(_ animated: Bool) {    
    self.tableView.reloadData()
    scrollToBottom()
    //self.navigationController?.tabBarController?.tabBar.items?[1].isEnabled = false
    self.navigationController?.tabBarController?.tabBar.items?[1].badgeColor = .black
    
  }

  override func didReceiveMemoryWarning() {
      super.didReceiveMemoryWarning()
  }

  
  // MARK: - Collection View
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return viewModel!.numberOfHoles
  }
  

  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "scorecardHoleCell", for: indexPath) as! ScorecardHoleCell
    cell.num.text = String(viewModel!.holes[indexPath.item].number)
    
    let par = viewModel!.holes[indexPath.item].par
    if indexPath.item < viewModel!.holesPlayed.count{
      let score = viewModel!.holesPlayed[indexPath.item].count
      cell.score.text = String(score)
      if score < par {
        cell.score.layer.backgroundColor = UIColor.green.cgColor
      }
      else if score > par {
        cell.score.layer.backgroundColor = UIColor.red.cgColor
      }
    }
    else{
      cell.score.text = "-"
    }
    
    cell.par.text = String(par)
    cell.dist.text = String(viewModel!.holes[indexPath.item].distance )
    
    
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
  
  // MARK: - Table View
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return viewModel!.strokes.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "StrokeCell", for: indexPath) as! StrokeCell


    for i in 0..<(clubs.count) {

      
      if clubs[i]["id"] as! Int == viewModel!.strokes[indexPath.row].club{
        cell.strokeLabel.text = clubs[i]["name"] as! String

      }
    }
    
    return cell
  }
  
  func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
    let holeNum = viewModel!.holesPlayed.count + 1
    return "Hole \(holeNum)"
  }
  
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return CGFloat(40)
  }
  
  
  
  func scrollToBottom(){
    if viewModel?.strokes.count as! Int > 0 {
      let indexPath = IndexPath(row: (viewModel?.strokes.count as! Int) - 1, section: 0)
      tableView.scrollToRow(at: indexPath, at: .bottom, animated: true)
    }
  }
  
//  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
//    startRoundButton.isEnabled = true
//    startRoundButton.setTitle("Start Round", for: .normal)
//    viewModel.course = (tableView.cellForRow(at: indexPath) as! ScorecardCourseCell).course!
//  }
//
  
  // MARK: - IBActions
  
  @IBAction func startCompleteHole(_ sender: UIButton){
    inHole = !inHole
    if inHole{
      let holeNum = viewModel!.numberOfHolesPlayed + 1
      newStrokeButton.isEnabled = true
      newStrokeButton.layer.borderColor = UIColor.black.cgColor
      let title = "Complete Hole #\(holeNum)"
      holeButton.setTitle(title, for: .normal)
      
      viewModel!.currHole = viewModel!.holes[holeNum-1].holeId
      
      completeScorecardButton.isEnabled = false
      completeScorecardButton.layer.borderColor = UIColor.gray.cgColor
    }
    else {
      
      viewModel!.holesPlayed.append(viewModel!.strokes)
      viewModel!.createScorecardHole(completion: { [unowned self] in
        DispatchQueue.main.async {
          self.viewModel!.createStrokes()
          self.viewModel!.strokes = []
          self.tableView.reloadData()
          self.collectionView.reloadData()
          
          let holeNum = self.viewModel!.numberOfHolesPlayed + 1
          self.newStrokeButton.isEnabled = false
          self.newStrokeButton.layer.borderColor = UIColor.gray.cgColor
          let title = "Start Hole #\(holeNum)"
          self.holeButton.setTitle(title, for: .normal)
          self.completeScorecardButton.isEnabled = true
          self.completeScorecardButton.layer.borderColor = UIColor.black.cgColor

        }
        })
      

    }
  }
  
  @IBAction func completeRound(_ sender: UIButton){

    (self.navigationController as! AddScorecardNavigationController).currScorecard = false
    self.navigationController!.popToRootViewController(animated: true)
    self.navigationController?.tabBarController?.tabBar.items?[1].isEnabled = true
    self.navigationController?.tabBarController?.tabBar.items?[1].badgeColor = .black

    viewModel!.reset()

  }
  
  
  // MARK: - Navigation
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

    location.getCurrentLocation()
    let vc = segue.destination as! StrokeInputNavigationViewController
    vc.latitude = Double(location.latitude)
    vc.longitude = Double(location.longitude)
    vc.viewModel = viewModel
    
  }
  
  
}
