//
//  GoalsVC.swift
//  LiterallyGoals
//
//  Created by Sean Saoirse on 24/11/18.
//  Copyright © 2018 Sean Saoirse. All rights reserved.
//

import UIKit

class GoalsVC: UIViewController,UITableViewDelegate, UITableViewDataSource {
    

   
    @IBOutlet weak var myTableView: UITableView!
    var arr = ["9", "21", "123"]
    override func viewDidLoad() {
        super.viewDidLoad()
        
        myTableView.delegate = self
        myTableView.dataSource = self

        // Do any additional setup after loading the view.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = myTableView.dequeueReusableCell(withIdentifier: "cell") as? GoalCell else {return UITableViewCell()}
        
        cell.myLabel.text = arr[indexPath.row]
        
        return cell
    }
    

    @IBAction func addGoalBtnPressed(_ sender: Any) {
        
    }
    

}
