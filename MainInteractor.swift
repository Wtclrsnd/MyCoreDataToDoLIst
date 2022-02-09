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
    
    func getNotesRawData(name: String, text: String) {
        print(name)
        worker.saveNewNote(name: name, text: text)
    }
    
    init(_ worker: CoreDataWorker) {
        self.worker = worker
    }
    
    
}
