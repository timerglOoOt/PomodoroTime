import Foundation
import UIKit

class TabBarController: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()

        let timerModel = TimerViewModel()
        let tasksViewModel = TasksViewModel()
        let firstViewController = TimerViewController(viewModel: timerModel)
        let secondViewController = TasksViewController(viewModel: tasksViewModel)

        firstViewController.tabBarItem = UITabBarItem(title: "Timer", image: UIImage(systemName: "clock.fill"), tag: 0)
        secondViewController.tabBarItem = UITabBarItem(title: "Tasks", image: UIImage(systemName: "list.bullet"), tag: 1)

        viewControllers = [firstViewController, secondViewController]
    }
}
