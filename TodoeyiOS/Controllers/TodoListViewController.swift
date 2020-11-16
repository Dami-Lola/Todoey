//
//  ViewController.swift
//  TodoeyiOS
//
//  Created by Damilola Okafor on 11/15/20.
//  Copyright © 2020 Damilola Okafor. All rights reserved.
//

import UIKit

class TodoListViewController: UITableViewController {
    
    
    let dataFilePath = FileManager.default.urls(for:
         .documentDirectory, in: .userDomainMask)
         .first?.appendingPathComponent("Items.plist")
   
    var itemArray = [Item]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let newItem = Item()
        newItem.title = "Miles Morals"
        itemArray.append(newItem)
        
        let newItem2 = Item()
        newItem2.title = "TOnue eie"
        itemArray.append(newItem2)
        
        let newItem4 = Item()
        newItem4.title = "Opleme Lmake"
        itemArray.append(newItem4)
        
//        if let items = defaults.array(forKey: "ToDoItemCell") as? [Item]{
//            itemArray = items
//        }
        // Do any additional setup after loading the view.
    }
    
    
    //MARK:- UITableViewDataSource
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
 
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        
        let item = itemArray[indexPath.row]
        
        
        let items = item.title
        cell.textLabel?.text = items
        
        cell.accessoryType = item.done ? .checkmark : .none
        
        
        return cell
    }
    
    //MARK:- UITableViewDelegate
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        itemArray[indexPath.row].done = !itemArray[indexPath.row].done
        
        saveItems()
        tableView.deselectRow(at: indexPath, animated: true)
        
        
    }
    
    //MARK:- Add New Items
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add New Todoey Item", message: "", preferredStyle: .alert)
        
        
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            
            let newItem = Item()
            newItem.title = textField.text!
            self.itemArray.append(newItem)
            self.saveItems()
            
        
        }
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Creat new item"
            textField = alertTextField
            
        }
        
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
      //MARK:- Model Manipulation Methods
    
    func saveItems(){
        
        let encoding = PropertyListEncoder()
        
        
        do{
            
            let data = try encoding.encode(itemArray)
            
            try data.write(to: dataFilePath!)
        }
        
        catch{
            
            print("Error encoding array\(error)")
        }
        
        self.tableView.reloadData()
    }
    
}

