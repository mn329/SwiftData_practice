//
//  TodoRepository.swift
//  Todo_data
//

import Foundation
import SwiftData

/// SwiftData への読み書きを担当するデータアクセス層
@MainActor
final class TodoRepository {
  private let modelContext: ModelContext

  init(modelContext: ModelContext) {
    self.modelContext = modelContext
  }

  func insert(title: String) {
    let trimmed = title.trimmingCharacters(in: .whitespacesAndNewlines)
    guard !trimmed.isEmpty else { return }
    modelContext.insert(TodoItem(title: trimmed))
  }

  func delete(_ item: TodoItem) {
    modelContext.delete(item)
  }

  func deleteItems(at offsets: IndexSet, in items: [TodoItem]) {
    for index in offsets {
      modelContext.delete(items[index])
    }
  }

  func toggleCompletion(of item: TodoItem) {
    item.isCompleted.toggle()
  }
}
