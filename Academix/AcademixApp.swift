//
//  AcademixApp.swift
//  Academix
//
//  Created by Changhao Song on 2021-06-21.
//

import SwiftUI

@main
struct AcademixApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
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
