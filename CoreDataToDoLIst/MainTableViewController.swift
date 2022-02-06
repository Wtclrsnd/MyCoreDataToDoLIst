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
    
    private var notes = ["abc", "sosi", "chlen"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpUI()
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.reloadData()

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
    
    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = notes[indexPath.row]
        return cell
    }
    
    
}

