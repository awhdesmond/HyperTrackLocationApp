//
//  ShoppingListCell.swift
//  locationApp
//
//  Created by John Yong on 9/23/17.
//  Copyright © 2017 desmond.ang.a0093896H. All rights reserved.
//

import UIKit

protocol ShoppingListDelegate {
    func updateShoppingLists(list: [String])
}

class ShoppingListCell: UICollectionViewCell {
    @IBOutlet var tableView: UITableView!
    
    var shoppingListDelegate: ShoppingListDelegate!
    var list = ["", ""]
    var canDelete = true
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setupTableView()
    }
    
    private func setupTableView() {
        let tableViewWidth = self.bounds.size.width
        let tableViewHeight = self.bounds.size.height
        let tableViewRect = CGRect(origin: self.bounds.origin, size: CGSize(width: tableViewWidth, height: tableViewHeight))
        tableView = UITableView(frame: tableViewRect)
        tableView.register(ListItemCell.self, forCellReuseIdentifier: "list row")
        tableView.delegate = self
        tableView.dataSource = self
        tableView.layer.borderWidth = 2.0;
        tableView.layer.borderColor = UIColor.black.cgColor
        tableView.layer.cornerRadius = 10;
        self.addSubview(tableView)
    }
}

extension ShoppingListCell: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.count + 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell: ListItemCell = ListItemCell(style: UITableViewCellStyle.value1, reuseIdentifier: "list row")
        let frame = cell.frame
        let origin = CGPoint(x: frame.origin.x + 10, y: frame.origin.y + 10)
        let size = CGSize(width: frame.width * 0.75, height: frame.height - 20)
        cell.selectionStyle = UITableViewCellSelectionStyle.none

        let tf = UITextField(frame: CGRect(origin: origin, size: size))
        tf.font = UIFont.systemFont(ofSize: 15)
        
        let row = indexPath.row
        if row == 0 {
            tf.placeholder = "Enter store name.."
        } else if row == list.count {
            addButton(cell: cell)
            return cell
        } else {
            tf.placeholder = "Enter item name.."
        }
        
        if list[row] != "" {
            tf.text = list[row]
        }
        tf.delegate = self
        cell.contentView.addSubview(tf)
        return cell
    }
    
    private func addButton(cell: UITableViewCell) {
        let size = CGSize(width: tableView.frame.width, height: cell.frame.height)
        let button = UIButton(frame: CGRect(origin: cell.frame.origin, size: size))
        button.backgroundColor = UIColor.gray
        button.setTitle("+ Add item", for: .normal)
        cell.contentView.addSubview(button)
        button.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
    }
    
    @objc private func buttonAction(sender: UIButton!) {
        list.append("")
        tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return indexPath.row != 0 && indexPath.row != list.count
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == UITableViewCellEditingStyle.delete && canDelete {
            list.remove(at: indexPath.row)
            tableView.reloadData()
        }
    }
}

extension ShoppingListCell: UITableViewDelegate {
    
}

extension ShoppingListCell: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        canDelete = false
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        let position = textField.convert(CGPoint.zero, to: tableView)
        let indexPath = tableView.indexPathForRow(at: position)!
        list[indexPath.row] = textField.text!
        canDelete = true
    }
}

extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    func dismissKeyboard() {
        view.endEditing(true)
    }
}
