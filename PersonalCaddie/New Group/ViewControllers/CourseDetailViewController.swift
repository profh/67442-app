//
//  CourseDetailViewController.swift
//  PersonalCaddie
//
//  Created by Philip Baker on 11/30/18.
//  Copyright © 2018 67442. All rights reserved.
//

import UIKit

class CourseDetailViewController: UIViewController {

  var viewModel: CourseDetailViewModel?
  @IBOutlet var cid: UILabel!
  
  
  
    override func viewDidLoad() {
        super.viewDidLoad()
      if let vm = viewModel{
        cid.text = String(vm.course.courseId)
      }

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
  override func viewWillAppear(_ animated: Bool){
    if let vm = viewModel{
      vm.refresh()
    }
    
    // Do any additional setup after loading the view.
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
