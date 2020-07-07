//
//  HomeTableViewController.swift
//  Simple Enrollment
//
//  Created by Alexander Roca on 7/5/20.
//  Copyright © 2020 Alexander Roca. All rights reserved.
//

import UIKit
import SDWebImage

class HomeTableViewController: UITableViewController {
    
    var enrollments: [EnrollmentInfo] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        getAllData()
    }
    
    func getAllData() {
        WebService.getAllData(completion: { response in
            self.enrollments = response
            self.tableView.reloadData()
        })
    }
    
    @IBAction func swipeRefresh(_ sender: UIRefreshControl) {
        getAllData()
        sender.endRefreshing()
        
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return enrollments.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! HumanTableViewCell
        let human = enrollments[indexPath.row]
        cell.nameLabel?.text = human.firstName + " " + human.lastName
        cell.idNoLabel?.text = human.idNo
        cell.imageViewHuman?.sd_setImage(with: URL(string: human.imageUrl), placeholderImage: UIImage(named: "avatar.png"))
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selected = enrollments[indexPath.row]
        performSegue(withIdentifier: "viewDetails", sender: selected)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let detailVC = segue.destination as? DetailsViewController {
            if let selectedItem = sender as? EnrollmentInfo {
                detailVC.enrollment = selectedItem
            }
        }
    }
}
