//
//  NewTaskViewController.swift
//  PomodoroTime
//
//  Created by Тимур Хайруллин on 16.04.2024.
//

import UIKit

class NewTaskViewController: UIViewController {
    private let newTaskView = NewTaskView(frame: .zero)
    private var viewModel: NewTaskViewModel
    private let hours = Array(0...23)
    private let minutesAndSecond = Array(0...59)
    private var selectedHours = 0
    private var selectedMinutes = 0
    private var selectedSeconds = 0

    override func loadView() {
        view = newTaskView
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        newTaskView.delegate = self
        newTaskView.configurePickerViewDelegate(with: self)
        newTaskView.configurePickerViewDataSource(with: self)
    }

    init(viewModel: NewTaskViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension NewTaskViewController {
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
}

extension NewTaskViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 3
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return component == 0 ? hours.count: minutesAndSecond.count
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return component == 0 ? "\(hours[row]) h"
            : component == 1 ? "\(minutesAndSecond[row]) min"
            : "\(minutesAndSecond[row]) sec"
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
            if component == 0 {
                selectedHours = hours[row]
            } else if component == 1 {
                selectedMinutes = minutesAndSecond[row]
            } else {
                selectedSeconds = minutesAndSecond[row]
            }
        }
}


extension NewTaskViewController: NewTaskDelegate {
    func saveTaskButtonTapped(taskName: String) {
        guard !taskName.isEmpty else {
            let alertController = UIAlertController(title: "Error", message: "Please enter a task name", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alertController.addAction(okAction)
            present(alertController, animated: true, completion: nil)
            return
        }
        viewModel.saveTask(name: taskName,
                           hours: selectedHours,
                           minutes: selectedMinutes,
                           seconds: selectedSeconds)
        dismiss(animated: true)
    }

    func configure(with taskName: String) {
        newTaskView.taskNameTextField.text = taskName
    }
}
