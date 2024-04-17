//
//  AppRouter.swift
//  PomodoroTime
//
//  Created by Тимур Хайруллин on 16.04.2024.
//

import Foundation
import UIKit

enum Screen {
    case main
    case tasks
    case new(name: String?)
}

class AppRouter {

    weak var currentTabBarController: UITabBarController?

    func routeTo(_ screen: Screen) {

        switch screen {
        case .main:
            break
        case .new(let name):
            let newTaskViewModel = NewTaskViewModel()
            let newTaskViewController = NewTaskViewController(viewModel: newTaskViewModel)

            newTaskViewController.configure(with: name ?? "")
            currentTabBarController?.present(newTaskViewController, animated: true)
        case .tasks:
            break
        }
    }
}
