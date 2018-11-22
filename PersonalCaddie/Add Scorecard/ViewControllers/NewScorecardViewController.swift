//
//  NewScorecardViewController.swift
//  PersonalCaddie
//
//  Created by Philip Baker on 11/14/18.
//  Copyright © 2018 67442. All rights reserved.
//

import UIKit


let clubs =
  [[
    "id": 1,
    "name": "Driver"
    ],
   [
    "id": 3,
    "name": "3 Wood"
    ],
   [
    "id": 4,
    "name": "4 Iron"
    ],
   [
    "id": 5,
    "name": "5 Iron"
    ],
   [
    "id": 6,
    "name": "6 Iron"
    ],
   [
    "id": 7,
    "name": "7 Iron"
    ],
   [
    "id": 8,
    "name": "8 Iron"
    ],
   [
    "id": 9,
    "name": "9 Iron"
    ],
   [
    "id": 10,
    "name": "PW"
    ],
   [
    "id": 11,
    "name": "AW"
    ],
   
   [
    "id": 12,
    "name": "60"
    ],
   [
    "id": 2,
    "name": "Putter"
    ]
]


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

    print("QQQQQQQQQQQQQQQQQ", viewModel!.strokes[indexPath.row].club, clubs[viewModel!.strokes[indexPath.row].club] )
    for i in 0..<(clubs.count) {

//      if let index = club.index(where: {(Int($0["id"]) == viewModel!.strokes[indexPath.row].club)}) {
//        print(index)
//      }
      
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
  
  @IBAction func startHole(_ sender: UIButton){
    inHole = !inHole
    if inHole{
      let holeNum = viewModel!.numberOfHolesPlayed + 1
      newStrokeButton.isEnabled = true
      let title = "Complete Hole #\(holeNum)"
      holeButton.setTitle(title, for: .normal)
    }
    else {
      
      viewModel!.holesPlayed.append(viewModel!.strokes)
      viewModel!.strokes = []
      tableView.reloadData()
      collectionView.reloadData()
      
      let holeNum = viewModel!.numberOfHolesPlayed + 1
      newStrokeButton.isEnabled = false
      let title = "Start Hole #\(holeNum)"
      holeButton.setTitle(title, for: .normal)

    }
  }
  
  @IBAction func completeRound(_ sender: UIButton){

    (self.navigationController as! AddScorecardNavigationController).currScorecard = false
    self.navigationController!.popViewController(animated: true)
    
    
    viewModel!.reset()

    // create everything !!!!!!
    // reset everything  !!!!!!

  }
  
  

  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

    location.getCurrentLocation()
    let vc = segue.destination as! StrokeInputNavigationViewController
    vc.latitude = Double(location.latitude)
    vc.longitude = Double(location.longitude)
    vc.viewModel = viewModel
    
  }
  
  
  
  
}
