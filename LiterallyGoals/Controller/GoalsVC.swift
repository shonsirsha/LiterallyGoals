//
//  GoalsVC.swift
//  LiterallyGoals
//
//  Created by Sean Saoirse on 24/11/18.
//  Copyright © 2018 Sean Saoirse. All rights reserved.
//

import UIKit
import CoreData

let appDelegate = UIApplication.shared.delegate as? AppDelegate
class GoalsVC: UIViewController,UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var myTableView: UITableView!
    
    
    
    var goals: [Goal] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        myTableView.delegate = self
        myTableView.dataSource = self
        
        myTableView.estimatedRowHeight = 70
        myTableView.rowHeight = UITableView.automaticDimension

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchCoreDataObj()
        myTableView.reloadData()

    }
    
    func fetchCoreDataObj(){
        self.fetch { (complete) in
            if complete{
                if goals.count > 0{
                    myTableView.isHidden = false
                }else{
                    myTableView.isHidden = true
                }
            }else{
                
            }
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return goals.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = myTableView.dequeueReusableCell(withIdentifier: "cell") as? GoalCell else {return UITableViewCell()}
        let goal = goals[indexPath.row]
        cell.configCell(goal: goal)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .none
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        var allGoals = goals[indexPath.row]

        if allGoals.goalCompletionValue != allGoals.goalProgress{
            let addAction = UITableViewRowAction(style: .normal, title: "ADD 1") { (rowAction, indexPath) in
                self.setProgress(indexPath: indexPath)
                tableView.reloadRows(at: [indexPath], with: .automatic)
            }
            
            addAction.backgroundColor = #colorLiteral(red: 0, green: 0.5898008943, blue: 1, alpha: 1)
            
            let deleteAction = UITableViewRowAction(style: .destructive, title: "DELETE") { (rowAction, indexPath) in
                self.removeGoal(indexPath: indexPath)
                self.fetchCoreDataObj()
                tableView.deleteRows(at: [indexPath], with: .automatic)
            }
            
            deleteAction.backgroundColor = #colorLiteral(red: 1, green: 0.1491314173, blue: 0, alpha: 1)
            
            return [deleteAction, addAction]
        }else{
            let deleteAction = UITableViewRowAction(style: .destructive, title: "DELETE") { (rowAction, indexPath) in
                self.removeGoal(indexPath: indexPath)
                self.fetchCoreDataObj()
                tableView.deleteRows(at: [indexPath], with: .automatic)
            }
            
            deleteAction.backgroundColor = #colorLiteral(red: 1, green: 0.1491314173, blue: 0, alpha: 1)
            return [deleteAction]
        }
        
       
    
    }
    
    @IBAction func addGoalBtnPressed(_ sender: Any) {
        guard let createGoalVC = storyboard?.instantiateViewController(withIdentifier: "CreateGoalVC") else {return}
        
        presentDetail(createGoalVC)
    }
    

}

extension GoalsVC{
    
    func setProgress(indexPath: IndexPath){
        guard let managedContext = appDelegate?.persistentContainer.viewContext else {return}
        
        let chosenGoal = goals[indexPath.row]
        
        if chosenGoal.goalProgress < chosenGoal.goalCompletionValue{
            chosenGoal.goalProgress += 1
        }else{
                return
        }
        
        do{
            try managedContext.save()
            print("SUCCESS adding progress")
        }catch{
            debugPrint("Couldnt add progress \(error.localizedDescription)")
        }
    }
    
    func removeGoal(indexPath: IndexPath){
        guard let managedContext = appDelegate?.persistentContainer.viewContext else {return}
        
        managedContext.delete(goals[indexPath.row])
        
        do{
            try managedContext.save()
            print("SUCCESS removing goal")
        }catch{
            debugPrint("Couldnt remove \(error.localizedDescription)")
        }
    }
    
    func fetch(completion: (_ complete: Bool)->()){
        guard let managedContext = appDelegate?.persistentContainer.viewContext else {return}
        
        let fetchRequest = NSFetchRequest<Goal>(entityName: "Goal")
        
        do{
            goals = try managedContext.fetch(fetchRequest) as! [Goal] // returns an array of Goal
            completion(true)
            print("SUCCESS FETCHING")
        }catch{
            debugPrint("Cant fetch \(error.localizedDescription)")
            completion(false)
        }
    }
    
    
}
