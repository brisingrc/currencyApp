//
//  CoursesController.swift
//  currencyApp
//
//  Created by Мак on 8/8/19.
//  Copyright © 2019 Aidar Zhussupov. All rights reserved.
//

import UIKit

class CoursesController: UITableViewController {
    @IBAction func refreshAction(_ sender: Any) {
        Model.shared.loadXMLFile(date: nil)
        Model.shared.currentDate = Date()
       
        let df = DateFormatter()
        df.dateFormat = "dd.MM.yyyy"
        navigationItem.title = df.string(from: Model.shared.currentDate)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

     
//
        NotificationCenter.default.addObserver(forName: NSNotification.Name(rawValue: "dataRefreshed"), object: nil, queue: nil) { (notification) in
            
            DispatchQueue.main.async {
                self.tableView.reloadData()
                let df = DateFormatter()
                df.dateFormat = "dd.MM.yyyy"
               // self.navigationItem.title = df.string(from: Model.shared.currentDate)
//                self.navigationItem.title = Model.shared.currentDate
                
                self.navigationItem.title = "\(Model.shared.currentDate)"
                
               
            }
            
            
            
        }
        
        let df = DateFormatter()
        df.dateFormat = "dd.MM.yyyy"
       navigationItem.title = df.string(from: Model.shared.currentDate)

        
   //  navigationItem.title = Model.shared.currentDate
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return Model.shared.currencies.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! CourseViewCell

        let courseForCell = Model.shared.currencies[indexPath.row]
        
        cell.initCell(currency: courseForCell)
//        cell.textLabel?.text = courseForCell.fullname
//        cell.detailTextLabel?.text = courseForCell.description
        
        return cell
    }
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }

 
}
