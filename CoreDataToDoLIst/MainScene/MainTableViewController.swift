//
//  ViewController.swift
//  CoreDataToDoLIst
//
//  Created by Emil Shpeklord on 06.02.2022.
//

import UIKit

protocol MainInteractorInputProtocol: AnyObject {
    func getNotesRawData(name: String, text: String)
    func updateNote(note: Note, newName: String, newText: String)
    func deleteNote(note: Note)
    func getAllNotes()
}

protocol MainTableViewControllerDelegate: AnyObject {
    func passNewNote(name: String, text: String)
    func passNote(note: Note, newName: String, newText: String)
    func deleteNote(note: Note)
}

class MainTableViewController: UIViewController, MainTableViewControllerInputProtocol, MainTableViewControllerDelegate {
    
    var output: MainInteractorInputProtocol?
    
    private lazy var tableView: UITableView = {
        let table = UITableView()
        table.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        return table
    }()
    
    private var allNotes = Notes()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpUI()
        
        tableView.delegate = self
        tableView.dataSource = self
        output?.getAllNotes()
        tableView.reloadData()
        
        //        output?.getNotesRawData(name: "1", text: "abc")
    }
    
    private func setUpUI() {
        
        view.backgroundColor = .systemBackground
        
        let rightItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.add, target: self, action: #selector(add))
        navigationItem.rightBarButtonItem = rightItem
        navigationController?.navigationBar.prefersLargeTitles = true
        title = "Notes"
        navigationController?.navigationBar.tintColor = .systemPink
        
        view.addSubview(tableView)
        tableView.frame = view.bounds
        
    }
    
    /// displays all stored notes
    func passNotes(notes: Notes) {
        allNotes = notes
        tableView.reloadData()
    }
    
    /// gets all stored notes from Core Data
    func getAllNotes() {
        output?.getAllNotes()
        tableView.reloadData()
    }
    
    @objc func add() {
        let vc = DetailNoteViewController()
        vc.delegate = self
        vc.isExisting = false
        navigationController?.pushViewController(vc, animated: true)
    }
    
    /// here we get a new note and store it to Core Data
    func passNewNote(name: String, text: String) {
        output?.getNotesRawData(name: name, text: text)
        output?.getAllNotes()
    }
    
    /// update selected note
    func passNote(note: Note, newName: String, newText: String) {
        output?.updateNote(note: note, newName: newName, newText: newText)
        output?.getAllNotes()
    }
    
    func deleteNote(note: Note) {
        output?.deleteNote(note: note)
        output?.getAllNotes()
    }
}

extension MainTableViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allNotes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = allNotes[indexPath.row].name
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = DetailNoteViewController()
        vc.delegate = self
        vc.isExisting = true
        vc.currentNote = allNotes[indexPath.row]
        vc.textField.text = allNotes[indexPath.row].name
        vc.textView.text = allNotes[indexPath.row].text //u can make a method in detailVC to pass data
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            allNotes.remove(at: indexPath.row)
            output?.deleteNote(note: allNotes[indexPath.row])
            output?.getAllNotes()
            tableView.reloadData()
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
}
