//
//  CreateGoalVC.swift
//  LiterallyGoals
//
//  Created by Sean Saoirse on 25/11/18.
//  Copyright © 2018 Sean Saoirse. All rights reserved.
//

import UIKit

class CreateGoalVC: UIViewController,UITextViewDelegate {

    @IBOutlet weak var myTextView: UITextView!
    @IBOutlet weak var shortTermBtn: UIButton!
    @IBOutlet weak var longTermBtn: UIButton!
    @IBOutlet weak var nextBtn: UIButton!
    
    var goalType: GoalType = .shortTerm
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nextBtn.bindToKeyboard()
        shortTermBtn.setSelectedColor()
        longTermBtn.setDeselectedColor()
        myTextView.delegate = self

    }
    @IBAction func shortTermBtnPressed(_ sender: Any) {
        goalType = .shortTerm
        shortTermBtn.setSelectedColor()
        longTermBtn.setDeselectedColor()
    }
    
    @IBAction func longTermButtonPressed(_ sender: Any) {
        goalType = .longTerm
        shortTermBtn.setDeselectedColor()
        longTermBtn.setSelectedColor()
    }
    
    @IBAction func nextBtnPressed(_ sender: Any) {
        if myTextView.text != "" && myTextView.text != "What's your goal?"{
            myTextView.resignFirstResponder()
            guard let finishGoalVC = storyboard?.instantiateViewController(withIdentifier: "FinishGoalVC") as? FinishGoalVC else {return}
            
            finishGoalVC.initData(description: myTextView.text!, type: goalType)
            
            presentingViewController?.presentSecondaryDetail(finishGoalVC)
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        myTextView.resignFirstResponder()
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        myTextView.text = ""
        myTextView.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
    }
    
    @IBAction func backBtnPressed(_ sender: Any) {
        myTextView.resignFirstResponder()
        dismissDetail()
    }
    
}
