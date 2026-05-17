//
//  FilteredTodoListViewModel.swift
//  Todo_data
//

import Foundation

@Observable
@MainActor
final class FilteredTodoListViewModel {
  private let repository: TodoRepository

  let emptyStateTitle = "タスクがありません"
  let emptyStateSystemImage = "checklist"
  let emptyStateDescription = "右下の+から追加できます"

  init(repository: TodoRepository) {
    self.repository = repository
  }

  func toggleCompletion(for todo: TodoItem) {
    repository.toggleCompletion(of: todo)
  }

  func delete(at offsets: IndexSet, from todos: [TodoItem]) {
    repository.deleteItems(at: offsets, in: todos)
  }

  func completionIconName(for todo: TodoItem) -> String {
    todo.isCompleted ? "checkmark.circle.fill" : "circle"
  }

  func isStrikethrough(for todo: TodoItem) -> Bool {
    todo.isCompleted
  }

  func titleForegroundIsSecondary(for todo: TodoItem) -> Bool {
    todo.isCompleted
  }
}
