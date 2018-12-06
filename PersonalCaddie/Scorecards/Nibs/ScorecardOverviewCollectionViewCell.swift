//
//  ScorecardOverviewCollectionViewCell.swift
//  PersonalCaddie
//
//  Created by Philip Baker on 11/12/18.
//  Copyright © 2018 67442. All rights reserved.
//

import UIKit

class ScorecardOverviewCollectionViewCell: UICollectionViewCell {
  @IBOutlet weak var courseNameLabel: UILabel!
  @IBOutlet weak var dateLabel: UILabel!
  @IBOutlet weak var holesPlayedLabel: UILabel!
  @IBOutlet weak var scoreLabel: UILabel!
  @IBOutlet weak var puttsPerHoleLabel: UILabel!
  @IBOutlet weak var pars: UILabel!
  
  override func awakeFromNib() {
      super.awakeFromNib()
  }

}
