//
//  TasksView.swift
//  Arbeit
//
//  The main list of tasks.
//

import SwiftUI

/// Lists all tasks. Tap a row to see details, swipe to delete, or tap +
/// to add a new task in a sheet.
struct TasksView: View {
    @Environment(TasksViewModel.self) private var viewModel
    @State private var showingNewTask = false

    /// The task list with its toolbar, new-task sheet and navigation destination.
    var body: some View {
        List {
            ForEach(viewModel.tasks) { task in
                NavigationLink(value: task) {
                    TaskRowView(task: task)
                }
            }
            .onDelete(perform: deleteTask)
        }
        .navigationTitle("Arbeit")
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button(action: { showingNewTask = true }) {
                    Image(systemName: "plus")
                }
            }
        }
        .sheet(isPresented: $showingNewTask) {
            NewTaskView()
                .environment(viewModel)
        }
        .navigationDestination(for: TaskItem.self) { task in
            TaskDetailsView(task: task)
        }
    }

    /// Deletes the tasks at the swiped indices.
    /// - Parameter offsets: The positions in the list that were swiped away.
    private func deleteTask(at offsets: IndexSet) {
        for index in offsets {
            viewModel.destroy(viewModel.tasks[index])
        }
    }
}
