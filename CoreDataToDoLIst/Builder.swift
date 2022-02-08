//
//  Builder.swift
//  CoreDataToDoLIst
//
//  Created by Emil Shpeklord on 08.02.2022.
//

import Foundation
import UIKit

final class Builder {
    
    func make() -> UINavigationController {
        let viewController = MainTableViewController()
        let interactor = MainInteractor()
        let presenter = MainPresenter()
        viewController.output = interactor
        interactor.output = presenter
        presenter.output = viewController
        
        let nav = UINavigationController(rootViewController: viewController)
        return nav
    }
}
