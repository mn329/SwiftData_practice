//
//  FilteredTodoListView.swift
//  Todo_data
//

import SwiftData
import SwiftUI

struct FilteredTodoListView: View {
  @Environment(\.modelContext) private var modelContext

  let viewModel: FilteredTodoListViewModel

  @Query private var todos: [TodoItem]

  init(filter: TodoListFilter, viewModel: FilteredTodoListViewModel) {
    self.viewModel = viewModel
    let includeCompleted = filter.showCompleted
    let searchQuery = filter.searchText
    _todos = Query(
      filter: #Predicate<TodoItem> { todo in
        (includeCompleted || todo.isCompleted == false)
          && (searchQuery.isEmpty || todo.title.localizedStandardContains(searchQuery))
      },
      sort: \TodoItem.createdAt,
      order: .reverse
    )
  }

  var body: some View {
    Group {
      if todos.isEmpty {
        ContentUnavailableView(
          viewModel.emptyStateTitle,
          systemImage: viewModel.emptyStateSystemImage,
          description: Text(viewModel.emptyStateDescription)
        )
      } else {
        List {
          ForEach(todos) { todo in
            HStack(alignment: .center, spacing: 12) {
              Button {
                withAnimation(.snappy) {
                  viewModel.toggleCompletion(for: todo)
                }
              } label: {
                Image(systemName: viewModel.completionIconName(for: todo))
                  .font(.title3)
                  .foregroundStyle(todo.isCompleted ? .green : .gray)
                  .frame(width: 28, height: 28)
                  .contentShape(Rectangle())
              }
              .buttonStyle(.plain)

              NavigationLink {
                TodoDetailView(
                  viewModel: TodoDetailViewModel(
                    todo: todo,
                    repository: TodoRepository(modelContext: modelContext)
                  )
                )
              } label: {
                VStack(alignment: .leading, spacing: 4) {
                  Text(todo.title)
                    .strikethrough(viewModel.isStrikethrough(for: todo))
                    .foregroundStyle(
                      viewModel.titleForegroundIsSecondary(for: todo) ? .gray : .primary
                    )
                  Text(todo.createdAtFormatted)
                    .font(.caption)
                    .foregroundStyle(.secondary)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
              }
            }
          }
          .onDelete { indexSet in
            viewModel.delete(at: indexSet, from: todos)
          }
        }
        .scrollContentBackground(.hidden)
      }
    }
  }
}
