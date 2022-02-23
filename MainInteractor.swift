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

	func exampleNote() {
		worker.saveNewNote(name: "Example", text: "Hi CFT!")
	}
	
	func getNotesRawData(name: String, text: String) {
		worker.saveNewNote(name: name, text: text)
	}
	
	func updateNote(note: Note, newName: String, newText: String) {
		worker.updateNote(note: note, newName: newName, newText: newText)
	}
	
	func deleteNote(note: Note) {
		worker.deleteNote(note: note)
	}
	
	func getAllNotes() {
		let notes = worker.getAllNotes()
		output?.getAllNotes(notes)
	}
}
