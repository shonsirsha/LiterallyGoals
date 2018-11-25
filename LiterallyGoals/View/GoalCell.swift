//
//  GoalCell.swift
//  LiterallyGoals
//
//  Created by Sean Saoirse on 24/11/18.
//  Copyright © 2018 Sean Saoirse. All rights reserved.
//

import UIKit

class GoalCell: UITableViewCell {
    @IBOutlet weak var myLabel: UILabel!
    @IBOutlet weak var goalLabel: UILabel!
    @IBOutlet weak var typeLabel: UILabel!
    
    @IBOutlet weak var completionView: UIView!
    func configCell(goal: Goal){
        self.goalLabel.text = "Goal: \(goal.goalDescription!)"
        self.typeLabel.text = goal.goalType
        self.myLabel.text = String(describing:goal.goalProgress)
        
        if goal.goalProgress == goal.goalCompletionValue{
            self.completionView.isHidden = false
        }else{
            self.completionView.isHidden = true
        }
    }
}
