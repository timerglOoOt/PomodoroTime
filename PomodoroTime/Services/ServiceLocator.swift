//
//  ServiceLocator.swift
//  PomodoroTime
//
//  Created by Тимур Хайруллин on 16.04.2024.
//

import Foundation

class ServiceLocator {
    static let shared = ServiceLocator()

    private var services: [String: Any] = [:]

    private init() {}

    func register<T>(_ service: T) {
        let key = "\(T.self)"
        services[key] = service
    }

    func resolve<T>() -> T? {
        let key = "\(T.self)"
        return services[key] as? T
    }
}
