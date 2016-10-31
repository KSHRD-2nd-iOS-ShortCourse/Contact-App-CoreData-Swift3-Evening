//
//  PersonService.swift
//  CoreDataSwift3
//
//  Created by Kokpheng on 10/24/16.
//  Copyright © 2016 Kokpheng. All rights reserved.
//

import Foundation
import CoreData

class PersonService{
    
    var context: NSManagedObjectContext
    
    init(context: NSManagedObjectContext){
        self.context = context
    }
    
    // Creates a new Person
    func create(name: String, age: Int16) -> Person {
        
        let newItem = NSEntityDescription.insertNewObject(forEntityName: "Person", into: context) as! Person
        
        newItem.name = name
        newItem.age = age
        
        return newItem
    }
    
    // Gets a person by id
    func getById(id: NSManagedObjectID) -> Person? {
        return context.object(with: id) as? Person
    }
    
    // Gets all.
    func getAll() -> [Person]{
        return get(withPredicate: NSPredicate(value:true))
    }
    
    // Gets all that fulfill the specified predicate.
    // Predicates examples:
    // - NSPredicate(format: "name == %@", "Juan Carlos")
    // - NSPredicate(format: "name contains %@", "Juan")
    func get(withPredicate queryPredicate: NSPredicate) -> [Person]{
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Person")
        
        fetchRequest.predicate = queryPredicate
        
        do {
            let response = try context.fetch(fetchRequest)
            return response as! [Person]
            
        } catch let error as NSError {
            // failure
            print(error)
            return [Person]()
        }
    }
    
    // Updates a person
    func update(updatedPerson: Person){
        if let person = getById(id: updatedPerson.objectID){
            person.name = updatedPerson.name
            person.age = updatedPerson.age
        }
    }
    
    // Deletes a person
    func delete(id: NSManagedObjectID){
        if let personToDelete = getById(id: id){
            context.delete(personToDelete)
        }
    }
    
    // Saves all changes
    func saveChanges(){
        do{
            try context.save()
        } catch let error as NSError {
            // failure
            print(error)
        }
    }
}

