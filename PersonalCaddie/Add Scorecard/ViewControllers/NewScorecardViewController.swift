//
//  NewScorecardViewController.swift
//  PersonalCaddie
//
//  Created by Philip Baker on 11/14/18.
//  Copyright © 2018 67442. All rights reserved.
//

import UIKit



class NewScorecardViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UITableViewDataSource, UITableViewDelegate {

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
    }
    let holeNum = viewModel!.numberOfHolesPlayed + 1
    let title = "Start Hole #\(holeNum)"
    holeButton.setTitle(title, for: .normal)
    


    
  }
  
  override func viewWillAppear(_ animated: Bool) {    
    self.tableView.reloadData()
    scrollToBottom()
    self.navigationController?.tabBarController?.tabBar.items?.last?.isEnabled = false
  }

  override func viewWillDisappear(_ animated: Bool) {
    self.navigationController?.tabBarController?.tabBar.items?.last?.isEnabled = true
  }
  override func didReceiveMemoryWarning() {
      super.didReceiveMemoryWarning()
      // Dispose of any resources that can be recreated.
  }

  /*
  // MARK: - Navigation

  // In a storyboard-based application, you will often want to do a little preparation before navigation
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
      // Get the new view controller using segue.destinationViewController.
      // Pass the selected object to the new view controller.
  }
  */
  
  
  // MARK: - Collection View
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return viewModel!.numberOfHoles
  }
  

  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "scorecardHoleCell", for: indexPath) as! ScorecardHoleCell
    cell.num.text = String(viewModel!.holes[indexPath.item].number)
    if indexPath.item < viewModel!.holesPlayed.count{
      let score = viewModel!.holesPlayed[indexPath.item].count
      cell.score.text = String(score)
    }
    else{
      cell.score.text = "-"
    }
    
    cell.par.text = String(viewModel!.holes[indexPath.item].par)
    cell.dist.text = String(viewModel!.holes[indexPath.item].distance )

    return cell
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
      let holeNum = viewModel!.numberOfHolesPlayed + viewModel!.numberOfHolesPlayed + 1
      newStrokeButton.isEnabled = true
      let title = "Complete Hole #\(holeNum)"
      holeButton.setTitle(title, for: .normal)
      
      viewModel!.currHole = viewModel!.holes[holeNum].holeId
      
      completeScorecardButton.isEnabled = false
    }
    else {
      
      viewModel!.holesPlayed.append(viewModel!.strokes)
      // Stroke(club: clubId, lat: lat, lon: lon, contactType: ct, flightType: ft, finalLocation: lie)
      
      
      viewModel!.createScorecardHole(completion: { [unowned self] in
        DispatchQueue.main.async {
          self.viewModel!.createStrokes()
          self.viewModel!.strokes = []
          self.tableView.reloadData()
          self.collectionView.reloadData()
          
          let holeNum = self.viewModel!.numberOfHolesPlayed + 1
          self.newStrokeButton.isEnabled = false
          let title = "Start Hole #\(holeNum)"
          self.holeButton.setTitle(title, for: .normal)
          self.completeScorecardButton.isEnabled = true

        }
        })
      

    }
  }
  
  @IBAction func completeRound(_ sender: UIButton){

    (self.navigationController as! AddScorecardNavigationController).currScorecard = false
    self.navigationController!.popToRootViewController(animated: true)
    self.navigationController?.tabBarController?.tabBar.items?.last?.isEnabled = true

    viewModel!.reset()

  }
  
  

  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

    location.getCurrentLocation()
    let vc = segue.destination as! StrokeInputNavigationViewController
    vc.latitude = Double(location.latitude)
    vc.longitude = Double(location.longitude)
    vc.viewModel = viewModel
    
  }
  
  
  
  
}
