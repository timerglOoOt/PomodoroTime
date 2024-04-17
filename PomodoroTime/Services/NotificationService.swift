//
//  NotificationService.swift
//  PomodoroTime
//
//  Created by Тимур Хайруллин on 16.04.2024.
//

import Foundation

import UserNotifications

class NotificationService: NSObject {
    private let notificationCenter = UNUserNotificationCenter.current()

    override init() {
        super.init()

        notificationCenter.delegate = self
    }

    func registerForNotifications() async throws -> Bool {
        try await notificationCenter.requestAuthorization(options: [.alert, .badge, .sound])
    }

    func getNotificationSettings() async -> UNNotificationSettings {
        await notificationCenter.notificationSettings()
    }
}


extension NotificationService: UNUserNotificationCenterDelegate {
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification) async -> UNNotificationPresentationOptions {
        return [.banner, .sound]
    }

    func scheduleNotification(for task: Tasks) {
        let content = UNMutableNotificationContent()
        content.title = "Time for \(task.name) is up!"
        content.body = "It's time to take a break for 10 seconds or move to the next task."
        content.sound = UNNotificationSound.default

        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 1.0, repeats: false)
        let request = UNNotificationRequest(identifier: "custom_id", content: content, trigger: trigger)

        notificationCenter.add(request)
    }
}
