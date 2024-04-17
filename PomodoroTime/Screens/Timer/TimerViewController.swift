//
//  MainViewController.swift
//  PomodoroTime
//
//  Created by Тимур Хайруллин on 16.04.2024.
//

import UIKit
import Combine

class TimerViewController: UIViewController {
    private let mainView = TimerView(frame: .zero)
    private var viewModel: TimerViewModel
    private var cancellables = Set<AnyCancellable>()

    override func loadView() {
        view = mainView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        mainView.delegate = self
        setupBindings()
    }

    init(viewModel: TimerViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension TimerViewController {
    func setupBindings() {
        viewModel.$timeRemaining
            .sink { [weak self] time in
                self?.mainView.taskTime.isHidden = false
                self?.mainView.taskName.isHidden = false
                self?.mainView.taskTime.text = time.formattedString()
            }
            .store(in: &cancellables)

        viewModel.$curTaskName
            .sink { [weak self] name in
                self?.mainView.taskName.text = name
            }
            .store(in: &cancellables)
    }
}

extension TimerViewController: TimerDelegate {
    func pauseButtonTapped() {
        viewModel.pauseTimer()
    }

    func finishButtonTapped() {
        viewModel.finishTimer()
    }

    func startButtonTapped() {
        viewModel.startTimer()
    }
}
