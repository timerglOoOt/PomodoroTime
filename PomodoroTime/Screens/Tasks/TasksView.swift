//
//  TasksView.swift
//  PomodoroTime
//
//  Created by Тимур Хайруллин on 16.04.2024.
//
import Foundation
import UIKit

protocol TasksDelegate: AnyObject {
    func addNewTaskButtonTabbed()
}

class TasksView: UIView {
    private lazy var tasksNameLabel: UILabel = {
        let label = UILabel()
        label.text = "Tasks list"
        label.font = .systemFont(ofSize: 45, weight: .semibold)
        label.contentMode = .center
        return label
    }()

    private lazy var tasksTableView: UITableView = {
        let table = UITableView()
        table.register(TasksTableViewCell.self, forCellReuseIdentifier: TasksTableViewCell.reuseIdentifier)
        table.rowHeight = 40
        return table
    }()

    private lazy var addTaskButton: UIButton = {
        let button = UIButton(configuration: .bordered())
        button.setTitle("Add new task", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 14
        button.clipsToBounds = true
        button.backgroundColor = .systemBlue
        let action = UIAction { [weak self] _ in
            self?.delegate?.addNewTaskButtonTabbed()
        }
        button.addAction(action, for: .touchUpInside)
        return button
    }()

    weak var delegate: TasksDelegate?
    override init(frame: CGRect) {
        super.init(frame: frame)

        setupSubviews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension TasksView {
    func setupSubviews() {
        backgroundColor = .white
        addSubview(tasksNameLabel)
        addSubview(tasksTableView)
        addSubview(addTaskButton)

        tasksNameLabel.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide).offset(15)
            make.centerX.equalTo(safeAreaLayoutGuide)
        }

        tasksTableView.snp.makeConstraints { make in
            make.top.equalTo(tasksNameLabel.snp.bottom).offset(15)
            make.bottom.leading.trailing.equalTo(safeAreaLayoutGuide).inset(10)
        }

        addTaskButton.snp.makeConstraints { make in
            make.leading.trailing.equalTo(safeAreaLayoutGuide).inset(100)
            make.bottom.equalTo(safeAreaLayoutGuide).inset(20)
            make.height.equalTo(40)
        }
    }

    func setupDataSource(with dataSource: UITableViewDataSource) {
        self.tasksTableView.dataSource = dataSource
    }

    func setupDelegate(with delegate: UITableViewDelegate) {
        self.tasksTableView.delegate = delegate
    }

    func reloadData() {
        tasksTableView.reloadData()
    }
}
