//
//  AcademixApp.swift
//  Academix
//
//  Created by Changhao Song on 2021-06-21.
//

import SwiftUI
import Firebase

@main
struct AcademixApp: App {
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    var body: some Scene {
        WindowGroup {
            let viewModel = AppViewModel()
            MainView()
                .environmentObject(viewModel)
                .onAppear(perform: setupAppearance)
        }
    }
    
    func setupAppearance() {
        let backImage = UIImage(systemName: "chevron.backward")?
                .withPadding(.init(top: 2, left: 0, bottom: 0, right: -4))
        
        
        // Synchronize navigation bar style
        UINavigationBar.appearance().backIndicatorImage = backImage
        UINavigationBar.appearance().backIndicatorTransitionMaskImage = backImage
        UINavigationBar.appearance().shadowImage = UIImage()
        UINavigationBar.appearance().tintColor = UIColor(named: "navigation_tint")
        UINavigationBar.appearance().barTintColor = UIColor(named: "navigation_bar_tint")
    }
}

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    FirebaseApp.configure()
    return true
  }
}
