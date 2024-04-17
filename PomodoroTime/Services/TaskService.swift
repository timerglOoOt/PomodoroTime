//
//  TaskService.swift
//  PomodoroTime
//
//  Created by Тимур Хайруллин on 16.04.2024.
//

import Foundation

// MARK: Здесь я решил уже просто обращаться к TaskService, потому что Локатор был бы менее эффективен

class TaskService {
    public static let shared = TaskService()
    private init() {}
    
    @Published var tasks: [Tasks] = []

    func saveTask(_ task: Tasks) {
        tasks.append(task)
    }

    func removeTask(at index: Int) {
        tasks.remove(at: index)
    }

    func getTask(at index: Int) -> Tasks {
        tasks[index]
    }

    func getAllTasks() -> [Tasks] {
        tasks
    }

    func getCount() -> Int {
        tasks.count
    }

    func updateTask(duration: TimeInterval) {
        tasks[0].duration = duration
    }
}
