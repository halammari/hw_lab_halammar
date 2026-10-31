//
//  ArbeitApp.swift
//  Arbeit
//
//  App entry point. Configures Firebase at launch and shows AppView.
//

import SwiftUI
import FirebaseCore

/// UIKit app delegate used only to configure Firebase when the app launches.
class AppDelegate: NSObject, UIApplicationDelegate {

    /// Called once the app has finished launching. Configures Firebase using
    /// the GoogleService-Info.plist bundled with the app.
    /// - Returns: `true` to indicate the app launched successfully.
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil) -> Bool {
        FirebaseApp.configure()
        return true
    }
}

/// The main SwiftUI app. Bridges in the AppDelegate and starts with AppView.
@main
struct ArbeitApp: App {
    /// Registers AppDelegate so Firebase gets configured on launch.
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate

    /// The app's single window scene, rooted at AppView.
    var body: some Scene {
        WindowGroup {
            // Start with AppView, not generic ContentView
            AppView()
        }
    }
}
