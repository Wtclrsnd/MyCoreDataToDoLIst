//
//  MainInteractor.swift
//  CoreDataToDoLIst
//
//  Created by Emil Shpeklord on 08.02.2022.
//

import Foundation

typealias Notes = [Note]

protocol MainPresenterInputProtocol: AnyObject {
    func getAllNotes(_ notes: Notes)
}

final class MainInteractor: MainInteractorInputProtocol {
    
    var output: MainPresenterInputProtocol?
    
    private var worker: CoreDataWorker
    
   
    init(_ worker: CoreDataWorker) {
        self.worker = worker
    }
    
    func getNotesRawData(name: String, text: String) {
        worker.saveNewNote(name: name, text: text)
    }
    
    func updateNote(note: Note, newName: String, newText: String) {
        worker.updateNote(note: note, newName: newName, newText: newText)
    }
    
    func getAllNotes() {
        var notes = worker.getAllNotes()
        output?.getAllNotes(notes)
    }
}
