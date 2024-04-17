//
//  PomodoroSnapshotTest.swift
//  PomodoroTimeTests
//
//  Created by Тимур Хайруллин on 16.04.2024.
//

import XCTest
import SnapshotTesting
@testable import PomodoroTime

final class PomodoroSnapshotTest: XCTestCase {
    let timerViewModel = TimerViewModel()
    lazy var timerViewController = TimerViewController(viewModel: timerViewModel)


    let tasksViewModel = TasksViewModel()
    lazy var tasksViewController = TasksViewController(viewModel: tasksViewModel)

    func test_timer_screen_on_iphone_13ProMax_landscape() throws {
        assertSnapshots(of: timerViewController, as: [.image(on: .iPhone13ProMax(.landscape))])
    }

    func test_timer_screen_on_iphone_13ProMax_portrait() throws {
        assertSnapshots(of: timerViewController, as: [.image(on: .iPhone13ProMax(.portrait))])
    }

    func test_tasks_screen_on_iPad_landscape() throws {
        assertSnapshots(of: tasksViewController, as: [.image(on: .iPad10_2(.landscape))])
    }
}
