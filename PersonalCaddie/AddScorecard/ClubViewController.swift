//
//  ClubViewController.swift
//  PersonalCaddie
//
//  Created by Philip Baker on 11/13/18.
//  Copyright © 2018 67442. All rights reserved.
//

import UIKit

class ClubViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
  
  
  @IBOutlet var collectionView: UICollectionView!
  var clubs = ["Driver", "5 Iron", "Putter"]
  
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view.
    let nibCell = UINib(nibName: "StrokeInputCollectionViewCell", bundle: nil)
    
    collectionView!.register(nibCell, forCellReuseIdentifier: "strokeInputCell")
    
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  // MARK: - Collection View
  func collectionView(_ collectionView: UICollectionView, numberOfRowsInSection section: Int) -> Int {
    return 3
  }
  //  func numberOfSections(in collectionView: UICollectionView) -> Int {
  //    return 1
  //  }
  
  func collectionView(_ collectionView: UICollectionView, cellForRowAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withIdentifier: "strokeInputCell", for: indexPath) as! StrokeInputCollectionViewCell
    
    cell.value.text = clubs[indexPath.row]
    return cell
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
