//
//  ViewController.swift
//  CoreDataToDoLIst
//
//  Created by Emil Shpeklord on 06.02.2022.
//

import UIKit

class MainTableViewController: UIViewController {

    private lazy var tableView: UITableView = {
        let table = UITableView()
        table.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        return table
    }()
    
    private var notes = ["1", "2", "3"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpUI()
    }

    private func setUpUI() {
        
        view.backgroundColor = .systemBackground
        
        let rightItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.add, target: self, action: #selector(add))
        self.navigationItem.rightBarButtonItem = rightItem
        self.navigationController?.navigationBar.prefersLargeTitles = true
        title = "Notes"
        self.navigationController?.navigationBar.tintColor = .systemPink
        
        view.addSubview(tableView)
        tableView.frame = view.bounds
    }

    @objc func add() {
        
    }
}

extension MainTableViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let note = notes[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = note
        return cell
    }
    
    
}

