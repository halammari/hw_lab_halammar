//
//  AppView.swift
//  Arbeit
//
//  Root view: owns the view model and sets up the tab bar.
//

import SwiftUI

/// Creates the shared TasksViewModel and injects it into a two-tab
/// interface (task list and new task), each with its own NavigationStack.
struct AppView: View {
    @State private var tasksViewModel = TasksViewModel()

    /// The tab bar with the Tasks and New Task tabs.
    var body: some View {
        TabView {
            NavigationStack {
                TasksView()
            }
            .tabItem {
                Image(systemName: "checkmark.rectangle.stack.fill")
                Text("Tasks")
            }

            NavigationStack {
                NewTaskView()
            }
            .tabItem {
                Image(systemName: "plus.app.fill")
                Text("New Task")
            }
        }
        .environment(tasksViewModel)
    }
}
