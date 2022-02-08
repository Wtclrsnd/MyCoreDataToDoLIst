//
//  DetailNoteViewController.swift
//  CoreDataToDoLIst
//
//  Created by Emil Shpeklord on 08.02.2022.
//

import UIKit

class DetailNoteViewController: UIViewController {
    
    private lazy var textView: UITextView = {
        let textView = UITextView()
        textView.font = .systemFont(ofSize: 30)
//        textView.contentInset = UIEdgeInsets(top: 20, left: 10, bottom: 20, right: 10)
        return textView
    }()
    override func viewDidLoad() {
        super.viewDidLoad()

        setUpUI()
    }

    private func setUpUI() {
        view.addSubview(textView)
        
        view.backgroundColor = .systemBackground
        textView.backgroundColor = .systemBackground
        
        textView.frame = view.bounds
        
        let rightItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.save, target: self, action: #selector(save))
        self.navigationItem.rightBarButtonItem = rightItem
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationController?.navigationBar.tintColor = .systemPink
    }

    @objc private func save() {
        navigationController?.popViewController(animated: true)
    }

}
