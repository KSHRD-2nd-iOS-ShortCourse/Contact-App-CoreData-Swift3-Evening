//
//  AddEditViewController.swift
//  CoreDataSwift3
//
//  Created by Kokpheng on 10/24/16.
//  Copyright © 2016 Kokpheng. All rights reserved.
//

import UIKit

class AddEditViewController: UIViewController {
    var person : Person!

    @IBOutlet var ageTextField: UITextField!
    @IBOutlet var nameTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        if person != nil {
            self.nameTextField.text = person.name
            self.ageTextField.text = "\(person.age)"
        }

    }

    @IBAction func Save(_ sender: UIButton) {
        // Create an instance of the service.
        
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let personService = PersonService(context: context)
        
        
        if person != nil {
            // Update existing contact info
            person.name = nameTextField.text
            person.age = Int16(ageTextField.text!)!
            personService.update(updatedPerson: person)
        }else{
            
            // Create
            _ = personService.create(name: nameTextField.text!, age: Int16(ageTextField.text!)!)
        }
        
        personService.saveChanges()
        
        
       _ = navigationController?.popViewController(animated: true) // After save go back to home.

    }
 
}
