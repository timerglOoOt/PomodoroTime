//
//  MainViewModel.swift
//  PomodoroTime
//
//  Created by Тимур Хайруллин on 16.04.2024.
//

import Foundation
import Combine

class TimerViewModel {
    let taskService = TaskService.shared
    @Published var timerState: TimerState = .relax
    @Published var timeRemaining: TimeInterval = 0
    @Published var curTaskName: String = "Relax man"

    private var cancellables = Set<AnyCancellable>()
    private var timer: Timer?

    func startTimer() {
        guard !(taskService.getCount() == 0), timerState != .running else { return }

        if timeRemaining == 0 {
            let duration = taskService.getTask(at: 0).duration
            timeRemaining = duration
        }
        curTaskName = taskService.getTask(at: 0).name
        timerState = .running

        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { [weak self] _ in
            guard let self = self else { return }
            if self.timeRemaining > 0 {
                self.timeRemaining -= 1
                self.taskService.updateTask(duration: self.timeRemaining)
            } else {
                self.finishTimer()
            }
        }
    }

    func pauseTimer() {
        guard timerState == .running else { return }
        timerState = .paused
        timer?.invalidate()
    }

    func finishTimer() {
        guard !(taskService.getCount() == 0),
                (timerState == .running || timerState == .paused) else { return }
        if let notificationService: NotificationService = ServiceLocator.shared.resolve() {
            notificationService.scheduleNotification(for: taskService.getTask(at: 0))
        }
        timerState = .finished
        timer?.invalidate()
        timeRemaining = 0
        self.moveToNextTask(with: 10)
        curTaskName = "Relax man"
    }

    func moveToNextTask(with rest: TimeInterval) {
        taskService.removeTask(at: 0)
        guard !(taskService.getCount() == 0) else { return }
        timer = Timer.scheduledTimer(withTimeInterval: rest, repeats: false) { [weak self] _ in
            self?.startTimer()
        }
    }
}
