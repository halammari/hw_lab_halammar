//
//  TaskItem.swift
//  Arbeit
//
//  The task model stored in the Firestore "tasks" collection.
//

import Foundation
import FirebaseFirestore

/// A single task. Codable so Firestore can convert it to/from a document,
/// Identifiable for SwiftUI lists, Comparable for sorting, and Hashable for
/// value-based navigation.
struct TaskItem: Identifiable, Comparable, Codable, Hashable {


    /// Firestore document ID. Nil until the task has been saved to Firestore.
    @DocumentID var id: String?
    var name: String
    var assignedTo: String
    var dueDate: Date
    var dateAdded: Date
    var completed: Bool


    /// Maps Swift property names to Firestore field names.
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case assignedTo
        case dueDate
        case dateAdded
        case completed
    }


    /// Two tasks are equal when their name, assignee and due date match.
    /// (The id and completion state are intentionally ignored.)
    static func ==(lhs: TaskItem, rhs: TaskItem) -> Bool {
        return lhs.name == rhs.name && lhs.assignedTo == rhs.assignedTo && lhs.dueDate == rhs.dueDate
    }

    /// Orders tasks alphabetically by name.
    static func <(lhs: TaskItem, rhs: TaskItem) -> Bool {
        return lhs.name < rhs.name
    }


    /// Hashes the same fields used by `==`, so equal tasks always produce
    /// equal hashes (required by the Hashable contract).
    func hash(into hasher: inout Hasher) {
        hasher.combine(name)
        hasher.combine(assignedTo)
        hasher.combine(dueDate)
    }
}

// MARK: - Validation

extension TaskItem {
    /// Checks that a task has both a name and an assignee.
    /// - Returns: `true` if neither field is empty.
    static func isValid(name: String, assignedTo: String) -> Bool {
        return !name.isEmpty && !assignedTo.isEmpty
    }
}
