//
//  DetailNoteViewController.swift
//  CoreDataToDoLIst
//
//  Created by Emil Shpeklord on 08.02.2022.
//

import UIKit

class DetailNoteViewController: UIViewController {

	weak var delegate: MainTableViewControllerDelegate?

	var isExisting: Bool?

	var currentNote: Note?

	private lazy var stack: UIStackView = {
		let stack = UIStackView()
		stack.translatesAutoresizingMaskIntoConstraints = false
		stack.axis = .vertical
		stack.distribution = .fill
		stack.spacing = 5
		return stack
	}()

	lazy var textField: UITextField = {
		let textField = UITextField()
		textField.font = .boldSystemFont(ofSize: 40)
		textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: textField.frame.height))
		textField.leftViewMode = .always
		textField.backgroundColor = .systemBackground
		return textField
	}()

	lazy var textView: UITextView = {
		let textView = UITextView()
		textView.font = .systemFont(ofSize: 30)
		textView.backgroundColor = .systemBackground
        textView.contentInset = UIEdgeInsets(top: 20, left: 10, bottom: 20, right: 10)
		return textView
	}()
	override func viewDidLoad() {
		super.viewDidLoad()

        addObservers()
		setUpUI()
	}

    deinit {
        NotificationCenter.default.removeObserver(UIResponder.keyboardWillHideNotification)
        NotificationCenter.default.removeObserver(UIResponder.keyboardWillShowNotification)
        NotificationCenter.default.removeObserver(UIResponder.keyboardWillChangeFrameNotification)
        print("Observers were removed")
    }

    private func addObservers() {
        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(
            self,
            selector: #selector(adjustForKeyboard),
            name: UIResponder.keyboardWillHideNotification,
            object: nil
        )
        notificationCenter.addObserver(
            self,
            selector: #selector(adjustForKeyboard),
            name: UIResponder.keyboardWillChangeFrameNotification,
            object: nil
        )
    }

    @objc func adjustForKeyboard(notification: Notification) {
        guard let keyboardValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else {
            return
        }

        let keyboardScreenEndFrame = keyboardValue.cgRectValue
        let keyboardViewAndFrame = view.convert(keyboardScreenEndFrame, from: view.window)

        if notification.name == UIResponder.keyboardWillHideNotification {
            textView.contentInset = .zero
            navigationItem.rightBarButtonItem = nil
        } else {
            textView.contentInset = UIEdgeInsets(
                top: 0,
                left: 0,
                bottom: keyboardViewAndFrame.height - view.safeAreaInsets.bottom,
                right: 0
            )
        }

        textView.scrollIndicatorInsets = textView.contentInset
        let selectedRange = textView.selectedRange
        textView.scrollRangeToVisible(selectedRange)
    }

	private func setUpUI() {
		view.addSubview(stack)
		stack.addArrangedSubview(textField)
		stack.addArrangedSubview(textView)

		stack.frame = view.bounds

		stack.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
		stack.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
		stack.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
		stack.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
		stack.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true

		view.backgroundColor = .systemBackground

		let rightItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.save, target: self, action: #selector(save))
		self.navigationItem.rightBarButtonItem = rightItem
		self.navigationController?.navigationBar.prefersLargeTitles = true
		self.navigationController?.navigationBar.tintColor = .systemPink
	}

	@objc private func save() {
		if textField.text == "" && textView.text == "" {
			if isExisting == true {
				delegate?.deleteNote(note: currentNote!)
			}
			navigationController?.popViewController(animated: true)
		} else {
			if isExisting! {
				delegate?.passNote(note: currentNote!, newName: textField.text!, newText: textView.text)
				navigationController?.popViewController(animated: true)
			} else {
				delegate?.passNewNote(name: textField.text!, text: textView.text)
				navigationController?.popViewController(animated: true)
			}
		}
	}


}
