//
//  MainPresenter.swift
//  CoreDataToDoLIst
//
//  Created by Emil Shpeklord on 08.02.2022.
//

import Foundation

protocol MainTableViewControllerInputProtocol: AnyObject {
	func passNotes(notes: Notes)
}

final class MainPresenter: MainPresenterInputProtocol {
	
	weak var output: MainTableViewControllerInputProtocol?
	
	func getAllNotes(_ notes: Notes) {
		output?.passNotes(notes: notes)
	}
	
}
