//
//  AppDelegate.swift
//  Academix
//
//  Created by Changhao Song on 2021-07-01.
//

import SwiftUI
import Firebase

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        
        FirebaseApp.configure()
        FirebaseConfiguration.shared.setLoggerLevel(.min)
        
        UNUserNotificationCenter.current().delegate = self
        
        let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
        UNUserNotificationCenter.current().requestAuthorization(
            options: authOptions) { _, _ in }
        
        application.registerForRemoteNotifications()
        Messaging.messaging().delegate = self
        
        return true
    }
}

extension AppDelegate: UNUserNotificationCenterDelegate {
    func userNotificationCenter(
        _ center: UNUserNotificationCenter,
        willPresent notification: UNNotification,
        withCompletionHandler completionHandler:
        @escaping (UNNotificationPresentationOptions) -> Void
    ) {
//        process(notification)
        completionHandler([[.banner, .sound]])
    }
    
    func userNotificationCenter(
        _ center: UNUserNotificationCenter,
        didReceive response: UNNotificationResponse,
        withCompletionHandler completionHandler: @escaping () -> Void
    ) {
//        process(response.notification)
        completionHandler()
    }
    
    func application(
        _ application: UIApplication,
        didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data
    ) {
        Messaging.messaging().apnsToken = deviceToken
    }
    
//    private func process(_ notification: UNNotification) {
//      let userInfo = notification.request.content.userInfo
//      UIApplication.shared.applicationIconBadgeNumber = 0
////      if let msgTitle = userInfo["msgTitle"] as? String,
////        let msgBody = userInfo["msgBody"] as? String {
////        let msg = Message(timestamp: <#T##Date#>, sender: <#T##User.ID#>, text: <#T##String#>)
////        CourseModel.shared
////        Analytics.logEvent("MSG_PROCESSED", parameters: nil)
////      }
//      Messaging.messaging().appDidReceiveMessage(userInfo)
//      Analytics.logEvent("NOTIFICATION_PROCESSED", parameters: nil)
//    }
}

extension AppDelegate: MessagingDelegate {
    func messaging(
        _ messaging: Messaging,
        didReceiveRegistrationToken fcmToken: String?
    ) {
        let tokenDict = ["token": fcmToken ?? ""]
        NotificationCenter.default.post(
            name: Notification.Name("FCMToken"),
            object: nil,
            userInfo: tokenDict)
    }
}
