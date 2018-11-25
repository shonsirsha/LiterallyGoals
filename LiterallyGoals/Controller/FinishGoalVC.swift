//
//  FinishGoalVC.swift
//  LiterallyGoals
//
//  Created by Sean Saoirse on 25/11/18.
//  Copyright © 2018 Sean Saoirse. All rights reserved.
//

import UIKit
import CoreData

class FinishGoalVC: UIViewController, UITextFieldDelegate {

    
    @IBOutlet weak var pointTextField: UITextField!
    @IBOutlet weak var createGoalBtn: UIButton!
    @IBOutlet weak var btc: NSLayoutConstraint!
    
    var goalDesc: String!
    var goalType: GoalType!
    
    func initData(description: String, type: GoalType){
        self.goalDesc = description
        self.goalType = type
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        pointTextField.delegate = self
        
        NotificationCenter.default.addObserver(self, selector: #selector(FinishGoalVC.keyboardWillShow(sender:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(FinishGoalVC.keyboardWillHide(sender:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        // Do any additional setup after loading the view.
    }

    
    @IBAction func createGoalBtnPressed(_ sender: Any) {//Pass data into coredata goal model
        if pointTextField.text != ""{
        self.save { (complete) in
            if complete{
                dismiss(animated: true, completion: nil)
            }
        }
    }
}
    
    @IBAction func backBtnPressed(_ sender: Any) {
        
        pointTextField.resignFirstResponder()
        dismissDetail()
    }
    
    
    
    func save(completion: (_ finished: Bool)->()){
        guard let managedContext = appDelegate?.persistentContainer.viewContext else {return}
        
        let goal = Goal(context: managedContext) // instance of core data
        
        goal.goalDescription = goalDesc
        goal.goalType = goalType.rawValue
        goal.goalCompletionValue = Int32(pointTextField.text!)!
        goal.goalProgress = Int32(0)
        
        do{
            try managedContext.save()
            completion(true)
            print("SUCCESS!")
        }catch{
            debugPrint("Couldnt save \(error.localizedDescription)")
            completion(false)
        }
        
    }
    
    @objc func keyboardWillShow(sender: NSNotification) {
        let duration = sender.userInfo![UIResponder.keyboardAnimationDurationUserInfoKey] as! Double
        let curve = sender.userInfo![UIResponder.keyboardAnimationCurveUserInfoKey] as! UInt
        let beginningFrame = (sender.userInfo![UIResponder.keyboardFrameBeginUserInfoKey] as! NSValue).cgRectValue
        let endFrame = (sender.userInfo![UIResponder.keyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        let deltaY = endFrame.origin.y - beginningFrame.origin.y
        
        UIView.animateKeyframes(withDuration: duration, delay: 0.0, options: UIView.KeyframeAnimationOptions(rawValue: curve), animations: {
            self.createGoalBtn.frame.origin.y += deltaY
        }, completion: nil)
        btc.constant += deltaY
        print(deltaY)
    }
    
    @objc func keyboardWillHide(sender: NSNotification) {
        let duration = sender.userInfo![UIResponder.keyboardAnimationDurationUserInfoKey] as! Double
        let curve = sender.userInfo![UIResponder.keyboardAnimationCurveUserInfoKey] as! UInt
        let beginningFrame = (sender.userInfo![UIResponder.keyboardFrameBeginUserInfoKey] as! NSValue).cgRectValue
        let endFrame = (sender.userInfo![UIResponder.keyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        let deltaY = endFrame.origin.y - beginningFrame.origin.y
        
        UIView.animateKeyframes(withDuration: duration, delay: 0.0, options: UIView.KeyframeAnimationOptions(rawValue: curve), animations: {
            self.createGoalBtn.frame.origin.y += deltaY
        }, completion: nil)
        btc.constant += deltaY
        print(deltaY)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        pointTextField.resignFirstResponder()
    }
    
  
    
}
