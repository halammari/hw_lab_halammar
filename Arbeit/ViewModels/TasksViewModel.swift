//
//  TasksViewModel.swift
//  Arbeit
//
//  The single view model the views use to read and change tasks.
//

import Foundation
import Observation

/// Exposes the repository's tasks to the views and forwards user actions
/// (add / update / delete) to the repository.
@Observable
class TasksViewModel {
    @ObservationIgnored private let repository: TaskRepository

    /// Creates the view model. The repository is injected so tests can
    /// supply their own; by default a real Firestore repository is used.
    init(repository: TaskRepository = TaskRepository()) {
        self.repository = repository
    }

    /// All tasks, read straight through from the repository.
    var tasks: [TaskItem] {
        repository.tasks
    }

    /// Saves a new task.
    func add(_ task: TaskItem) {
        repository.create(task)
    }

    /// Saves changes to an existing task.
    func update(_ task: TaskItem) {
        repository.update(task)
    }

    /// Deletes a task.
    func destroy(_ task: TaskItem) {
        repository.delete(task)
    }
}
