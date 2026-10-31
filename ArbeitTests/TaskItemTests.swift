//
//  TaskItemTests.swift
//  ArbeitTests
//
//  Unit tests for TaskItem's validation, equality and sorting.
//

import Testing
import Foundation
@testable import Arbeit

@MainActor
struct TaskItemTests {
    /// A fixed date so two samples compare equal (Date() differs each call).
    private static let fixedDate = Date(timeIntervalSince1970: 1_700_000_000)

    /// Builds a TaskItem with sensible defaults for testing.
    private func sample(name: String = "Write lab",
                        assignedTo: String = "Prof H",
                        dueDate: Date = TaskItemTests.fixedDate) -> TaskItem {
        TaskItem(
            name: name,
            assignedTo: assignedTo,
            dueDate: dueDate,
            dateAdded: TaskItemTests.fixedDate,
            completed: false
        )
    }

    /// An empty name should fail validation.
    @Test func validationRejectsEmptyName() {
        #expect(TaskItem.isValid(name: "", assignedTo: "someone") == false)
    }

    /// An empty assignee should fail validation.
    @Test func validationRejectsEmptyAssignee() {
        #expect(TaskItem.isValid(name: "something", assignedTo: "") == false)
    }

    /// A name and assignee together should pass validation.
    @Test func validationAcceptsBothPresent() {
        #expect(TaskItem.isValid(name: "something", assignedTo: "someone") == true)
    }

    /// Equality compares name, assignee and due date only.
    @Test func equalityIgnoresIdAndCompletion() {
        var a = sample()
        var b = sample()
        a.id = "abc"
        b.id = "xyz"
        b.completed = true   // completed is not part of `==`
        #expect(a == b)      // same name, assignedTo, dueDate
    }

    /// Sorting orders tasks alphabetically by name.
    @Test func sortsByName() {
        let apple = sample(name: "Apple")
        let banana = sample(name: "Banana")
        let cherry = sample(name: "Cherry")
        let sorted = [cherry, apple, banana].sorted()
        #expect(sorted.map(\.name) == ["Apple", "Banana", "Cherry"])
    }
}
