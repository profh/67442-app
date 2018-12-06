//
//  SubmitStrokeViewController.swift
//  PersonalCaddie
//
//  Created by Philip Baker on 12/6/18.
//  Copyright © 2018 67442. All rights reserved.
//

import UIKit

class SubmitStrokeViewController: UIViewController {

  @IBOutlet var club: UILabel!
  @IBOutlet var lie: UILabel!
  @IBOutlet var contact: UILabel!
  @IBOutlet var flight: UILabel!
  
  @IBOutlet var submitButton: UIButton!
  
    override func viewDidLoad() {
        super.viewDidLoad()
      
      let cancel = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelStroke))
      cancel.tintColor = UIColor.red
      self.navigationItem.rightBarButtonItems = [cancel]
      self.navigationItem.title = "Submit"
      
      if let clubId = (self.navigationController as! StrokeInputNavigationViewController).club{
        let clubVal  = clubs.filter {club in return club["id"] as! Int == clubId}
        club.text = clubVal.first!["name"] as! String
      }
      else{
        club.text = "-"
      }
      
      if let lie = (self.navigationController as! StrokeInputNavigationViewController).lie{
        self.lie.text = lie
      }
      else{
        self.lie.text = "-"
      }
      
      if let ct = (self.navigationController as! StrokeInputNavigationViewController).contactType{
        contact.text = ct
      }
      else{
        contact.text = "-"
      }
      
      if let ft = (self.navigationController as! StrokeInputNavigationViewController).flightType{
        flight.text = ft
      }
      else{
        flight.text = "-"
      }
      
      
      submitButton.layer.borderWidth = 1
      submitButton.layer.borderColor = UIColor.black.cgColor
      submitButton.layer.cornerRadius = 10


    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
  
  
  // MARK: - IBActions
  
  @IBAction func cancelStroke(_ sender: UIButton){
    self.navigationController!.dismiss(animated: true)
  }
  
  @IBAction func submit(_ sender: UIButton) {
    
    var lie: String?
    var contact: String?
    var flight: String?
    
    if let lon = (self.navigationController as! StrokeInputNavigationViewController).longitude,
      let lat = (self.navigationController as! StrokeInputNavigationViewController).latitude,
      let club = (self.navigationController as! StrokeInputNavigationViewController).club
    {
     
      if let ct = (self.navigationController as! StrokeInputNavigationViewController).contactType{
        contact = ct
      }
      if let ft = (self.navigationController as! StrokeInputNavigationViewController).flightType{
        flight = ft
      }
      if let l = (self.navigationController as! StrokeInputNavigationViewController).lie {
        lie = l
      }
      (self.navigationController! as! StrokeInputNavigationViewController).viewModel!.strokes.append(Stroke(club: club, lat: lat, lon: lon, contactType: contact, flightType: flight, finalLocation: lie))
      self.navigationController!.dismiss(animated: true)
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
