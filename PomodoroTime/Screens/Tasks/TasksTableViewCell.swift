//
//  TasksTableViewCell.swift
//  PomodoroTime
//
//  Created by Тимур Хайруллин on 16.04.2024.
//
import Foundation
import UIKit
import SnapKit

class TasksTableViewCell: UITableViewCell {
    private lazy var taskNameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 20, weight: .medium)
        return label
    }()
    private lazy var taskTimeLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 20, weight: .regular)
        return label
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        setupSubviews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension TasksTableViewCell {
    func setupSubviews() {
        addSubview(taskNameLabel)
        addSubview(taskTimeLabel)

        taskNameLabel.snp.makeConstraints { make in
            make.centerY.equalTo(safeAreaLayoutGuide)
            make.leading.equalTo(safeAreaLayoutGuide).offset(10)
        }

        taskTimeLabel.snp.makeConstraints { make in
            make.centerY.equalTo(safeAreaLayoutGuide)
            make.trailing.equalTo(safeAreaLayoutGuide).inset(10)
        }
    }
}

extension TasksTableViewCell {
    func configure(with task: Tasks) {
        taskNameLabel.text = task.name
        taskTimeLabel.text = task.duration.formattedString()
    }

    override func prepareForReuse() {
        super.prepareForReuse()

        taskTimeLabel.text = nil
        taskNameLabel.text = nil
    }

    static var reuseIdentifier: String {
        String(describing: self)
    }
}
