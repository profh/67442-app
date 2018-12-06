//
//  ScorecardCourseViewController.swift
//  PersonalCaddie
//
//  Created by Philip Baker on 11/14/18.
//  Copyright © 2018 67442. All rights reserved.
//

import UIKit

class ScorecardCourseViewController: UIViewController, UITableViewDataSource, UITableViewDelegate{


  @IBOutlet var tableView: UITableView!
  @IBOutlet var startRoundButton: UIButton!
  var viewModel: NewScorecardViewModel?
  
  override func viewDidLoad() {
      super.viewDidLoad()

    viewModel!.refreshCourses { [unowned self] in
      DispatchQueue.main.async {
        self.tableView?.reloadData()
      }
    }
    
    startRoundButton.layer.borderColor = UIColor.gray.cgColor
    startRoundButton.layer.borderWidth = 1
    startRoundButton.layer.cornerRadius = 10
    startRoundButton.setTitleColor(UIColor.gray, for: .disabled)
    startRoundButton.isEnabled = false
    startRoundButton.setTitle("Start Round", for: .normal)
    startRoundButton.setTitle("Select Course", for: .disabled)

  }

  override func didReceiveMemoryWarning() {
      super.didReceiveMemoryWarning()
  }
  
  override func viewWillAppear(_ animated: Bool) {

    if (self.navigationController as! AddScorecardNavigationController).currScorecard {
        let vc:NewScorecardViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "NewScorecardViewController") as! NewScorecardViewController
        vc.viewModel = (self.navigationController! as! AddScorecardNavigationController).viewModel
        self.navigationController!.pushViewController(vc, animated: true)
    }
    else {
      tableView.isUserInteractionEnabled = true
    }
  }

  
  // MARK: - Navigation
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    (segue.destination as! NewScorecardViewController).viewModel = viewModel

  }
  
  // MARK: - Table View
 
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return viewModel!.courses.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "ScorecardCourseCell", for: indexPath) as! ScorecardCourseCell
    cell.courseName!.text = viewModel!.courses[indexPath.row].name
    cell.course = viewModel!.courses[indexPath.row]
    return cell
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
    startRoundButton.isEnabled = true
    startRoundButton.layer.borderColor = UIColor.black.cgColor
    viewModel!.course = (tableView.cellForRow(at: indexPath) as! ScorecardCourseCell).course!
    }
  
  
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return CGFloat(70)
  }
  
  
  // MARK: - IBActions
  @IBAction func addScorecard(_sender: UIButton){
    (self.navigationController as! AddScorecardNavigationController).currScorecard = true
    tableView.isUserInteractionEnabled = false
    startRoundButton.isEnabled = false
    startRoundButton.layer.borderColor = UIColor.gray.cgColor

    viewModel!.createScorecard()
  }
}
