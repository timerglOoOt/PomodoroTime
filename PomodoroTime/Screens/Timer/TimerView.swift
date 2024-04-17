//
//  MainView.swift
//  PomodoroTimer
//
//  Created by Тимур Хайруллин on 16.04.2024.
//

import UIKit
import SnapKit

protocol TimerDelegate: AnyObject {
    func pauseButtonTapped()
    func finishButtonTapped()
    func startButtonTapped()
}

class TimerView: UIView {
    lazy var taskName: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 30, weight: .bold)
        label.textColor = .black
        return label
    }()

    lazy var taskTime: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 50, weight: .light)
        label.textColor = .black
        return label
    }()

    private lazy var startButton: UIButton = {
        let button = UIButton(configuration: .bordered())
        button.setTitle("Start", for: .normal)
        button.setTitleColor(.systemGreen, for: .normal)
        button.setTitleColor(.lightGray, for: .selected)
        let action = UIAction { [weak self] _ in
            self?.delegate?.startButtonTapped()
        }
        button.addAction(action, for: .touchUpInside)
        return button
    }()

    private lazy var pauseButton: UIButton = {
        let button = UIButton(configuration: .bordered())
        button.setTitle("Pause", for: .normal)
        button.setTitleColor(.systemOrange, for: .normal)
        button.setTitleColor(.lightGray, for: .selected)
        let action = UIAction { [weak self] _ in
            self?.delegate?.pauseButtonTapped()
        }
        button.addAction(action, for: .touchUpInside)
        return button
    }()

    private lazy var finishButton: UIButton = {
        let button = UIButton(configuration: .bordered())
        button.setTitle("Finish", for: .normal)
        button.setTitleColor(.systemRed, for: .normal)
        button.setTitleColor(.lightGray, for: .selected)
        let action = UIAction { [weak self] _ in
            self?.delegate?.finishButtonTapped()
        }
        button.addAction(action, for: .touchUpInside)
        return button
    }()

    private lazy var buttonStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [startButton, pauseButton, finishButton])
        stack.axis = .horizontal
        stack.spacing = 20
        stack.distribution = .fillEqually
        return stack
    }()

    weak var delegate: TimerDelegate?

    override init(frame: CGRect) {
        super.init(frame: frame)

        setupSubviews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension TimerView {
    private func setupSubviews() {
        backgroundColor = .white
        addSubview(taskName)
        addSubview(taskTime)
        addSubview(buttonStack)

        taskTime.snp.makeConstraints { make in
            make.center.equalTo(safeAreaLayoutGuide)
        }

        taskName.snp.makeConstraints { make in
            make.centerX.equalTo(safeAreaLayoutGuide)
            make.top.equalTo(safeAreaLayoutGuide).offset(105)
        }

        buttonStack.snp.makeConstraints { make in
            make.centerX.equalTo(safeAreaLayoutGuide)
            make.bottom.equalTo(safeAreaLayoutGuide).inset(30)
        }
    }
}
