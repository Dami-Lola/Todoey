//
//  ViewController.swift
//  TodoeyiOS
//
//  Created by Damilola Okafor on 11/15/20.
//  Copyright © 2020 Damilola Okafor. All rights reserved.
//

import UIKit
import CoreData

class TodoListViewController: UITableViewController {
    
    
    let context = (UIApplication.shared.delegate as! AppDelegate)
    .persistentContainer.viewContext
   
    var itemArray = [Item]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        loadItems()
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
            
        
            
            let newItem = Item(context: self.context)
            newItem.title = textField.text!
            newItem.done = false
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

        do {
            try context.save()
        } catch {
      
            print("Error saving context\(error)")
        }
        
        self.tableView.reloadData()
    }
    
    func loadItems(){

        let request: NSFetchRequest<Item> = Item.fetchRequest()

        do{
            itemArray = try context.fetch(request)

        }
        catch{
            print("Error fetching context\(error)")
        }
    }
 
 
}

