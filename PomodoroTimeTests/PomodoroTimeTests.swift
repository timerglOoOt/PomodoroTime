//
//  PomodoroTimeTests.swift
//  PomodoroTimeTests
//
//  Created by Тимур Хайруллин on 16.04.2024.
//

import XCTest
import Combine

@testable import PomodoroTime

final class PomodoroTimeTests: XCTestCase {
    let viewModel = TimerViewModel()
    var cancellables = Set<AnyCancellable>()

    func test_start_timer() {
        let expectation = expectation(description: "Start timer")

        viewModel.$timerState.sink { state in
            if state == .running {
                expectation.fulfill()
            }
        }.store(in: &cancellables)

        viewModel.startTimer()

        waitForExpectations(timeout: 1)
    }

    func test_pause_timer() {
        let expectation = expectation(description: "Pause timer")
        viewModel.startTimer()

        viewModel.$timerState.sink { state in
            if state == .paused {
                expectation.fulfill()
            }
        }.store(in: &cancellables)

        viewModel.pauseTimer()

        waitForExpectations(timeout: 1)
    }

    func test_finish_timer() {
        let expectation = expectation(description: "Finish timer")
        viewModel.startTimer()

        viewModel.$timerState.sink { state in
            if state == .finished {
                expectation.fulfill()
            }
        }.store(in: &cancellables)

        viewModel.finishTimer()

        waitForExpectations(timeout: 1)
    }
}
