//
//  CoreDataWorker.swift
//  CoreDataToDoLIst
//
//  Created by Emil Shpeklord on 08.02.2022.
//

import Foundation
import CoreData

final class CoreDataWorker {

    private lazy var persistentContainer: NSPersistentContainer = {
          let container = NSPersistentContainer(name: "SavingLearn")
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
        let notes = Notes()
        let fetchRequest: NSFetchRequest<Note> = Note.fetchRequest()
        do {
            let notes = try context.fetch(fetchRequest)
        } catch {
            print(error)
        }
        
        return notes
    }
    
    func saveNewNote(name: String, text: String) {
        let newItem = Note(context: context)
        newItem.name = name
        newItem.text = text
        print(name)
        saveContext()
    }
    
    func saveContext () {
          if context.hasChanges {
              do {
                  try context.save()
              } catch {
                context.rollback()
                  let nserror = error as NSError
                  fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
              }
          }
      }
}
