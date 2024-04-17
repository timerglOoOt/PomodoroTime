//
//  NewTaskViewModel.swift
//  PomodoroTime
//
//  Created by Тимур Хайруллин on 16.04.2024.
//

import Foundation

class NewTaskViewModel {
    func saveTask(name: String, hours: Int, minutes: Int, seconds: Int) {
        let interval = culcTimeInterval(hours: hours, minutes: minutes, seconds: seconds)
        let task = configureTask(name: name, interval: interval)
        TaskService.shared.saveTask(task)
    }

    func configureTask(name: String, interval: TimeInterval) -> Tasks {
        Tasks(name: name, duration: interval)
    }

    func culcTimeInterval(hours: Int, minutes: Int, seconds: Int) -> TimeInterval {
        return TimeInterval(hours * 3600 + minutes * 60 + seconds)
    }
}
