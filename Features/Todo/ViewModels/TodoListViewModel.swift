//
//  TodoListViewModel.swift
//  Todo_data
//

import Foundation

/// 一覧のフィルタ条件（`@Query` 生成時に View から参照）
struct TodoListFilter: Equatable {
  let showCompleted: Bool
  let searchText: String
}

@Observable
@MainActor
final class TodoListViewModel {
  var showCompleted = true
  var searchText = ""
  var isAddSheetPresented = false

  var filter: TodoListFilter {
    TodoListFilter(showCompleted: showCompleted, searchText: searchText)
  }

  var listIdentity: String {
    "\(showCompleted)_\(searchText)"
  }

  func presentAddSheet() {
    isAddSheetPresented = true
  }
}
