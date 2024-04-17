//
//  TasksViewController.swift
//  PomodoroTime
//
//  Created by Тимур Хайруллин on 16.04.2024.
//
import Foundation
import UIKit
import Combine

class TasksViewController: UIViewController {
    private let tasksView = TasksView(frame: .zero)
    private var viewModel: TasksViewModel
    private var cancellables = Set<AnyCancellable>()

    override func loadView() {
        view = tasksView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        tasksView.setupDataSource(with: self)
        tasksView.setupDelegate(with: self)
        tasksView.delegate = self

        setupBindings()
    }

    init(viewModel: TasksViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension TasksViewController {
    func setupBindings() {
        TaskService.shared.$tasks
            .sink { [weak self] _ in
                DispatchQueue.main.async {
                    self?.tasksView.reloadData()
                }
            }
            .store(in: &cancellables)
    }
}

extension TasksViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.numberOfRowsInSection()
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        viewModel.configureCell(tableView, cellForRowAt: indexPath)
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.cellForRow(at: indexPath)?.selectionStyle = .none
    }

    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        guard indexPath.row != 0 else { return nil }
        let deleteAction = UIContextualAction(style: .destructive, title: nil) { [weak self] (action, view, completionHandler) in
            self?.viewModel.removeTask(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .left)
            completionHandler(true)
        }
        deleteAction.image =  UIImage (systemName: "trash.fill")
        return UISwipeActionsConfiguration(actions: [deleteAction])
    }
}

extension TasksViewController: TasksDelegate {
    func addNewTaskButtonTabbed() {
        let newTaskViewModel = NewTaskViewModel()
        present(NewTaskViewController(viewModel: newTaskViewModel), animated: true)
    }
}
