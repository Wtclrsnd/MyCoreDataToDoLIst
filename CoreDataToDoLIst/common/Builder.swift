//
//  Builder.swift
//  CoreDataToDoLIst
//
//  Created by Emil Shpeklord on 08.02.2022.
//

import Foundation
import UIKit

final class Builder {
	
	private let coreDataWorker: CoreDataWorker
	
	func make() -> UINavigationController {
		let viewController = MainTableViewController()
		let interactor = MainInteractor(coreDataWorker)
		let presenter = MainPresenter()
		viewController.output = interactor
		interactor.output = presenter
		presenter.output = viewController
		
		let nav = UINavigationController(rootViewController: viewController)
		return nav
	}
	
	init(_ worker: CoreDataWorker) {
		self.coreDataWorker = worker
	}
}
