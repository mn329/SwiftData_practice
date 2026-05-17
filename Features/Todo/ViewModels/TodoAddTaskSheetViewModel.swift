//
//  TodoAddTaskSheetViewModel.swift
//  Todo_data
//

import Foundation

@Observable
@MainActor
final class TodoAddTaskSheetViewModel {
  private let repository: TodoRepository

  var draftTaskTitle = ""

  var trimmedTitle: String {
    draftTaskTitle.trimmingCharacters(in: .whitespacesAndNewlines)
  }

  var canSubmit: Bool {
    !trimmedTitle.isEmpty
  }

  var inputPreview: String {
    draftTaskTitle
  }

  init(repository: TodoRepository) {
    self.repository = repository
  }

  func resetDraft() {
    draftTaskTitle = ""
  }

  func submit() -> Bool {
    guard canSubmit else { return false }
    repository.insert(title: trimmedTitle)
    resetDraft()
    return true
  }
}
