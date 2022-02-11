//
//  CoreDataWorker.swift
//  CoreDataToDoLIst
//
//  Created by Emil Shpeklord on 08.02.2022.
//

import Foundation
import CoreData

//core data worker protocol

final class CoreDataWorker {
    
    private lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "CoreDataToDoLIst")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    private lazy var context: NSManagedObjectContext = {
        return persistentContainer.viewContext
    }()
    
    func getAllNotes() -> Notes {
        var notes = Notes()
        let fetchRequest: NSFetchRequest<Note> = Note.fetchRequest()
        do {
            notes = try context.fetch(fetchRequest)
        } catch let error as NSError {
            print(error.userInfo)
        }
        
        return notes
    }
    
    func saveNewNote(name: String, text: String) {
        let newItem = Note(context: context)
        newItem.name = name
        newItem.text = text
        saveContext()
    }
    
    func updateNote(note: Note, newName: String, newText: String) {
        note.name = newName
        note.text = newText
        saveContext()
    }
    
    func deleteNote(note: Note) {
        context.delete(note)
        saveContext()
    }
    
    private func saveContext() {
        if context.hasChanges {
            do {
                try context.save()
            } catch let error as NSError {
                context.rollback()
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        }
    }
}
