//
//  NewTaskView.swift
//  PomodoroTime
//
//  Created by Тимур Хайруллин on 16.04.2024.
//

import UIKit
import SnapKit

protocol NewTaskDelegate: AnyObject {
    func saveTaskButtonTapped(taskName: String)
}

class NewTaskView: UIView {
    lazy var taskNameTextField = UICustomTextField(placeholderText: "Task")

    private lazy var timePickerView: UIPickerView = {
        let pickerView = UIPickerView()
        return pickerView
    }()

    private lazy var saveTaskButton: UIButton = {
        let button = UIButton(configuration: .bordered())
        button.setTitle("Save new task", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 14
        button.clipsToBounds = true
        button.backgroundColor = .systemBlue
        let action = UIAction { [weak self] _ in
            guard let taskName = self?.taskNameTextField.text else { return }
            self?.delegate?.saveTaskButtonTapped(taskName: taskName)
        }
        button.addAction(action, for: .touchUpInside)
        return button
    }()
    
    weak var delegate: NewTaskDelegate?

    override init(frame: CGRect) {
        super.init(frame: frame)

        setupSubviews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
extension NewTaskView {
    private func setupSubviews() {
        backgroundColor = .white
        addSubview(taskNameTextField)
        addSubview(timePickerView)
        addSubview(saveTaskButton)

        taskNameTextField.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide).offset(40)
            make.leading.trailing.equalToSuperview().inset(20)
            make.height.equalTo(50)
        }

        timePickerView.snp.makeConstraints { make in
            make.top.equalTo(taskNameTextField.snp.bottom).offset(50)
            make.height.equalTo(250)
            make.leading.trailing.equalToSuperview()
        }

        saveTaskButton.snp.makeConstraints { make in
            make.leading.trailing.equalTo(safeAreaLayoutGuide).inset(100)
            make.bottom.equalTo(safeAreaLayoutGuide).inset(20)
            make.height.equalTo(40)
        }
    }

    func configurePickerViewDelegate(with delegate: UIPickerViewDelegate) {
        timePickerView.delegate = delegate
    }

    func configurePickerViewDataSource(with dataSource: UIPickerViewDataSource) {
        timePickerView.dataSource = dataSource
    }

}
