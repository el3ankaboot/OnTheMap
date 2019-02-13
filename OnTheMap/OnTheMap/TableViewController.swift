//
//  TableViewController.swift
//  OnTheMap
//
//  Created by Gamal Gamaleldin on 2/12/19.
//  Copyright © 2019 el3ankaboot. All rights reserved.
//

import Foundation
import UIKit


class TableViewController : UIViewController , UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
    
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    var students : [Student]! {
        return appDelegate.students
    }
    
    override func viewDidLoad() {
        
            super.viewDidLoad()
//            appDelegate.loadLocations()
            tableView.delegate = self
            tableView.dataSource = self
            
    
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(students.count)
        return students.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "studentReusable")!
        let student = self.students[(indexPath as NSIndexPath).row]
        
        
        cell.textLabel?.text = (student.firstName ?? "") + " " + (student.lastName ?? "")
        cell.detailTextLabel?.text = student.mediaURL ?? ""
    
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if let theURL = self.students[(indexPath as NSIndexPath).row].mediaURL{
            if let url = URL(string: theURL) {
                UIApplication.shared.open(url, options: [:])
            }
        }
    }
    

    
    @IBAction func refresh(_ sender: Any) {
        self.appDelegate.loadLocations()
        tableView.reloadData()
    }
    
    
    
}
