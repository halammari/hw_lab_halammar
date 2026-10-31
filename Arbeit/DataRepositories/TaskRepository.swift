//
//  TaskRepository.swift
//  Arbeit
//
//  Talks to Firestore. Owns the live list of tasks and the CRUD operations.
//

import Foundation
import Observation
import FirebaseFirestore

/// Source of truth for tasks. Keeps `tasks` in sync with the Firestore
/// "tasks" collection through a real-time snapshot listener.
@Observable
class TaskRepository {
    @ObservationIgnored private let path: String = "tasks"
    @ObservationIgnored private let store = Firestore.firestore()
    @ObservationIgnored private var listener: ListenerRegistration?

    /// The current tasks in Firestore; updates automatically.
    var tasks: [TaskItem] = []

    /// Creates the repository and immediately starts listening for tasks.
    init() {
        self.get()
    }

    /// Removes the Firestore listener so it doesn't leak.
    deinit {
        listener?.remove()
    }

    /// Attaches a snapshot listener to the tasks collection. Every time the
    /// collection changes, the documents are decoded into `tasks`.
    func get() {
        listener = store.collection(path)
            .addSnapshotListener { [weak self] querySnapshot, error in
                guard let self = self else { return }
                if let error = error {
                    print("Error getting tasks: \(error.localizedDescription)")
                    return
                }
                self.tasks = querySnapshot?.documents.compactMap { document in
                    try? document.data(as: TaskItem.self)
                } ?? []
            }
    }

    /// Adds a new task document to Firestore (Firestore generates the ID).
    func create(_ task: TaskItem) {
        do {
            _ = try store.collection(path).addDocument(from: task)
        } catch {
            print("Error creating task: \(error.localizedDescription)")
        }
    }

    /// Overwrites an existing task document. Requires the task to have an ID.
    func update(_ task: TaskItem) {
        guard let taskId = task.id else {
            print("Error updating task: Task ID is missing")
            return
        }
        do {
            try store.collection(path).document(taskId).setData(from: task)
        } catch {
            print("Error updating task: \(error.localizedDescription)")
        }
    }

    /// Deletes a task document from Firestore. Requires the task to have an ID.
    func delete(_ task: TaskItem) {
        guard let taskId = task.id else {
            print("Error deleting task: Task ID is missing")
            return
        }
        store.collection(path).document(taskId).delete { error in
            if let error = error {
                print("Error deleting task: \(error.localizedDescription)")
            }
        }
    }
}
