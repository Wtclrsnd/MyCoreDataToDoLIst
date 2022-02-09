//
//  MainPresenter.swift
//  CoreDataToDoLIst
//
//  Created by Emil Shpeklord on 08.02.2022.
//

import Foundation

protocol MainTableViewControllerInputProtocol: AnyObject {
    func passNewNote(name: String, text: String)
}

final class MainPresenter: MainPresenterInputProtocol {
    
    weak var output: MainTableViewControllerInputProtocol?

    
    func getAllNotes(_ notes: Notes) {
        var gotNotes = notes.compactMap { (name: $0.name, text: $0.text) }
//        output.
    }
    
}
