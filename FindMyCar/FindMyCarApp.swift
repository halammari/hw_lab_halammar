//
//  FindMyCarApp.swift
//  FindMyCar
//
//  Entry point of the app. Launches AppView inside the main window.
//

import SwiftUI

@main
struct FindMyCarApp: App {
    // Builds the app's scene hierarchy; the WindowGroup shows AppView as the root view
    var body: some Scene {
        WindowGroup {
            AppView()
        }
    }
}
