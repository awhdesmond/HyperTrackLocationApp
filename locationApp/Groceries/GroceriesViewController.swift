//
//  GroceriesViewController.swift
//  locationApp
//
//  Created by Ang Wei Hao Desmond on 23/9/17.
//  Copyright © 2017 desmond.ang.a0093896H. All rights reserved.
//

import UIKit

class GroceriesViewController: UIViewController {

    @IBOutlet weak var groceriesTable: UITableView!

    var data = ["chicken", "eggs", "ham"]
    @IBOutlet weak var groceryTextField: UITextField!
    
    @IBAction func addButtonPressed(_ sender: Any) {
        guard let grocery = groceryTextField.text, grocery != "" else {
            showAlert(message: "Please enter a grocery to purcahse")
            return
        }

        data.append(grocery)
        groceriesTable.reloadData()
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        groceriesTable.dataSource = self
        groceriesTable.delegate = self
    }
}

extension GroceriesViewController: UITableViewDelegate {}

extension GroceriesViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.groceriesTable.dequeueReusableCell(withIdentifier: "GroceryCell")!
        cell.textLabel?.text = self.data[indexPath.row]
        return cell
    }
}

extension GroceriesViewController {
    func showAlert(_ title: String = "Alert", message: String) {
        // create the alert
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        // add an action (button)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
        // show the alert
        self.present(alert, animated: true, completion: nil)
    }
}
