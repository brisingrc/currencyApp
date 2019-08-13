//
//  SettingViewController.swift
//  currencyApp
//
//  Created by Мак on 8/10/19.
//  Copyright © 2019 Aidar Zhussupov. All rights reserved.
//

import UIKit

class SettingViewController: UIViewController {
    @IBOutlet weak var dataPicker: UIDatePicker!
    @IBAction func pushCancelAction(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    @IBAction func pushCourses(_ sender: Any) {
        Model.shared.loadXMLFile(date: dataPicker.date)
        Model.shared.currentDate = dataPicker.date
    
        dismiss(animated: true, completion: nil)
    }
    
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
