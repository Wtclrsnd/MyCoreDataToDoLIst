//
//  DetailNoteViewController.swift
//  CoreDataToDoLIst
//
//  Created by Emil Shpeklord on 08.02.2022.
//

import UIKit

class DetailNoteViewController: UIViewController {
    
    weak var delegate: MainTableViewControllerDelegate?
    
    private lazy var stack: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.distribution = .fill
        stack.spacing = 5
        return stack
    }()
    
    private lazy var textField: UITextField = {
        let textField = UITextField()
        textField.font = .boldSystemFont(ofSize: 40)
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: textField.frame.height))
        textField.leftViewMode = .always
        textField.backgroundColor = .systemBackground
        return textField
    }()
    
    private lazy var textView: UITextView = {
        let textView = UITextView()
        textView.font = .systemFont(ofSize: 30)
        textView.backgroundColor = .systemBackground
        textView.contentInset = UIEdgeInsets(top: 20, left: 10, bottom: 20, right: 10)
        return textView
    }()
    override func viewDidLoad() {
        super.viewDidLoad()

        setUpUI()
    }

    private func setUpUI() {
        view.addSubview(stack)
        stack.addArrangedSubview(textField)
        stack.addArrangedSubview(textView)
        
        stack.frame = view.bounds
        
//        textField.heightAnchor.constraint(equalToConstant: 50)
        stack.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        stack.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        stack.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        stack.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        stack.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        
        view.backgroundColor = .systemBackground
//        textView.backgroundColor = .systemBackground
        
        let rightItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.save, target: self, action: #selector(save))
        self.navigationItem.rightBarButtonItem = rightItem
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationController?.navigationBar.tintColor = .systemPink
    }

    @objc private func save() {
        if textField.text == "" && textView.text == "" {
            navigationController?.popViewController(animated: true)
        } else {
            delegate?.passNote(name: textField.text!, text: textView.text)
            navigationController?.popViewController(animated: true)
        }
    }
    

}
