//
//  TodoDetailViewModel.swift
//  Todo_data
//

import Foundation

@Observable
@MainActor
final class TodoDetailViewModel {
  private let repository: TodoRepository

  let todo: TodoItem
  var showDeleteAlert = false

  var formattedCreatedAt: String {
    todo.createdAtFormatted
  }

  var deleteConfirmationMessage: String {
    "「\(todo.title)」を本当に削除しますか？\nこの操作は取り消せません。"
  }

  init(todo: TodoItem, repository: TodoRepository) {
    self.todo = todo
    self.repository = repository
  }

  func requestDelete() {
    showDeleteAlert = true
  }

  func cancelDelete() {
    showDeleteAlert = false
  }

  func confirmDelete() {
    repository.delete(todo)
  }
}
