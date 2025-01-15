//
//  PushNotificationsView.swift
//  IntermediateBootcamp
//
//  Created by David Cartwright on 2024-12-11.
//

import SwiftUI
import UserNotifications
import CoreLocation

//notifications by:
//date
//time (hourly, q2h, etc)
//by location

class NotificationManager {
    static let shared = NotificationManager()
    
    func requestAuthorization() {
        let options: UNAuthorizationOptions = [.alert, .sound, .badge]
        UNUserNotificationCenter.current().requestAuthorization(options: options) { success, error in
            if let error = error {
                print("\(String(describing: error))")
            } else {
                print("Success!")
            }
        }
    }
    
    func scheduleNotification() {
        let content = UNMutableNotificationContent()
        content.title = "This is my first notification!"
        content.subtitle = "This was soooooo easy!"
        content.sound = .default
        content.badge = 1
        
        
        //three types of triggers: time, calendar, location
        
        //location was deprecated and no easy fix without delving further into core location and /or other Apple APIs
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5.0, repeats: false)
        
//        var dateComponents = DateComponents()
//        dateComponents.hour = 08
//        dateComponents.minute = 00
//        dateComponents.weekday = 2 // 1 of 7?
//        
//        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
        
        
        let request = UNNotificationRequest(
            identifier: UUID().uuidString,
            content: content,
            trigger: trigger
        )
        
        UNUserNotificationCenter.current().add(request)
    }
    
    func cancelNotifications() {
        UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
        UNUserNotificationCenter.current().removeAllDeliveredNotifications()
    }
    
}


struct PushNotificationsView: View {
    var body: some View {
        VStack(spacing: 40) {
            Button("Request permission") {
                NotificationManager.shared.requestAuthorization()
                }
            
            Button("Schedule notification") {
                NotificationManager.shared.scheduleNotification()
            }
            
            Button("Cancel all notifications") {
                NotificationManager.shared.cancelNotifications()
            }
        }
        .onAppear {
//            UIApplication.shared.applicationIconBadgeNumber = 0
            UNUserNotificationCenter.current().setBadgeCount(0)
        }
        
    }
}

#Preview {
    PushNotificationsView()
}

