//
//  ConverterViewController.swift
//  currencyApp
//
//  Created by Мак on 8/11/19.
//  Copyright © 2019 Aidar Zhussupov. All rights reserved.
//

import UIKit

class ConverterViewController: UIViewController {
    @IBOutlet weak var labelCoursesForDate: UILabel!
    @IBOutlet weak var buttonFrom: UIButton!
    @IBOutlet weak var buttonTo: UIButton!
    
    @IBOutlet weak var textFrom: UITextField!
    
    @IBOutlet weak var textTo: UITextField!
    
    @IBAction func pushFromAction(_ sender: Any) {

        let ns = storyboard?.instantiateViewController(withIdentifier: "selectedCurrencyNSID") as! SelectCurrencyController
        
    ns.flagCurrency = .from
            present(ns, animated: true, completion: nil)
    }
    @IBAction func pushToAction(_ sender: Any) {
        let ns = storyboard?.instantiateViewController(withIdentifier: "selectedCurrencyNSID") as! SelectCurrencyController
        
        ns.flagCurrency = .to
        present(ns, animated: true, completion: nil)
    }
    @IBAction func textFromEdChanged(_ sender: Any) {
        let amount = Double(textFrom.text!)
        
        textTo.text = Model.shared.convert(amount: amount)
        
    }
    @IBOutlet weak var buttonDone: UIBarButtonItem!
    @IBAction func pushDoneAction(_ sender: Any) {
        textFrom.resignFirstResponder()
        navigationItem.rightBarButtonItem = nil
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

     textFrom.delegate = self
    }
    override func viewWillAppear(_ animated: Bool) {
        refreshButtons()
        textFromEdChanged(self)
        labelCoursesForDate.text = "\(Model.shared.currentDate)"
        
    }
    
    func refreshButtons(){
        buttonTo.setTitle(Model.shared.to.title, for: .normal)
        buttonFrom.setTitle(Model.shared.from.title, for: .normal)
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

extension ConverterViewController: UITextFieldDelegate {
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        navigationItem.rightBarButtonItem = buttonDone
        return true
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
}
