//
//  SelectCurrencyController.swift
//  currencyApp
//
//  Created by Мак on 8/11/19.
//  Copyright © 2019 Aidar Zhussupov. All rights reserved.
//

import UIKit

enum FlagCurrencySelected {
    case from
    case to
}

class SelectCurrencyController: UITableViewController {
    @IBAction func pushCancelAction(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    var flagCurrency: FlagCurrencySelected = .from
    
    override func viewDidLoad() {
        super.viewDidLoad()

      
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)

        let currentCurrency: Currency = Model.shared.currencies[indexPath.row]
        cell.textLabel?.text = currentCurrency.fullname
        return cell
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedCurrency: Currency = Model.shared.currencies[indexPath.row]
        if flagCurrency == .from {
            Model.shared.from = selectedCurrency
        }
        if flagCurrency == .to {
            Model.shared.to = selectedCurrency
        }
        dismiss(animated: true, completion: nil)
    }

  
 

}
