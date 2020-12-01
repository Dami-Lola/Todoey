//
//  CategoryViewController.swift
//  TodoeyiOS
//
//  Created by Damilola Okafor on 11/29/20.
//  Copyright © 2020 Damilola Okafor. All rights reserved.
//

import UIKit
import CoreData

class CategoryViewController: UITableViewController {
    
    let context = (UIApplication.shared.delegate as! AppDelegate)
        .persistentContainer.viewContext
    
    var categories = [Category]()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadCategories()
        
    }
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        let cell =  tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath)
        
        let item = categories[indexPath.row]
        cell.textLabel?.text = item.name
        
        
        return cell
        
    }
    
    
    // MARK: - Data manipluations
    
    func saveCategories(){
        
        do {
            try context.save()
        } catch {
            
            print("Error saving categories\(error)")
        }
        
        self.tableView.reloadData()
    }
    
    func loadCategories(with request: NSFetchRequest<Category> = Category.fetchRequest()){
        
        
        do{
            categories = try context.fetch(request)
            
        }
        catch{
            print("Error fetching categories\(error)")
        }
        
        tableView.reloadData()
    }
    
    // MARK: - Table view Delegate methods

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "goToItems", sender: self)
        
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! TodoListViewController
        
        if let indexPath = tableView.indexPathForSelectedRow{
            destinationVC.selectedCategory = categories[indexPath.row]
        }
    }
    
    
    
    
    
    
    // MARK: - Add categories
    
    @IBAction func addButtonPressed(_ sender:
        UIBarButtonItem) {
        
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add New Category", message: "", preferredStyle: .alert)
        
        
        let action = UIAlertAction(title: "Add Category", style: .default) { (action) in
            
            
            
            let newCategory = Category(context: self.context)
            newCategory.name = textField.text!
            self.categories.append(newCategory)
            self.saveCategories()
            
            
        }
        
            alert.addTextField {
                (alertTextField) in
            alertTextField.placeholder = "Create a new category"
            textField = alertTextField
            
        }
        
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
        
    }
    
}
