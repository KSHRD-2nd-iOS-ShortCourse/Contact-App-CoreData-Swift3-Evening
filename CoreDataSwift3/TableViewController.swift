//
//  ViewController.swift
//  CoreDataSwift3
//
//  Created by Kokpheng on 10/24/16.
//  Copyright © 2016 Kokpheng. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController {
    var data : [Person] = []


    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    override func viewWillAppear(_ animated: Bool) {
        // Create an instance of the service.
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
        let personService = PersonService(context: context)
        
        // Get all data
        data = personService.getAll()
        tableView.reloadData()
    }
    
    // MARK : TableView
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        // Return the number of rows in the section.
        return data.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Configure Cell
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell")!
        
        let data = self.data[indexPath.row]
        cell.textLabel?.text = data.name
        cell.detailTextLabel?.text = "Age: \(data.age)"
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
           
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }

    }
    
    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let delete = UITableViewRowAction(style: .destructive, title: "Delete") { action, index in
            // # Delete the row from the data source
            // Create an instance of the service.
            let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
            let personService = PersonService(context: context)
            
            // Read by id
            let deletedPerson = personService.getById(id: self.data[indexPath.row].objectID)!
            
            // Delete
            personService.delete(id: deletedPerson.objectID)
            personService.saveChanges()
            
            self.data.remove(at: indexPath.row)
            
            tableView.deleteRows(at: [indexPath as IndexPath], with: .fade)
        }
        
        let done = UITableViewRowAction(style: .default, title: "Edit") { action, index in
            self.performSegue(withIdentifier: "showEditInfo", sender: self.data[indexPath.row])
        }
        done.backgroundColor = UIColor.brown
        return [delete, done]
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showEditInfo"{
            let destViewController = segue.destination as! AddEditViewController
            destViewController.person = sender as! Person

        }
    }

}

