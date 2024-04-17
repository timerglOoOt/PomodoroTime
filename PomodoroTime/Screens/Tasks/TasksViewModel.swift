import Foundation
import UIKit
import Combine


class TasksViewModel {
    let taskService = TaskService.shared

    func numberOfRowsInSection() -> Int {
        taskService.getCount()
    }

    func configureCell(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TasksTableViewCell.reuseIdentifier, for: indexPath) as? TasksTableViewCell
        guard let cell = cell else { return UITableViewCell() }
        cell.configure(with: taskService.getTask(at: indexPath.row))

        return cell
    }

    func removeTask(at index: Int) {
        taskService.removeTask(at: index)
    }
}
