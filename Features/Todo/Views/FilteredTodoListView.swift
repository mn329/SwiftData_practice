//
//  FilteredTodoListView.swift
//  Todo_data
//

import SwiftData
import SwiftUI

/// クエリ結果に応じた Todo 一覧（完了表示のオン／オフでフィルタ）
struct FilteredTodoListView: View {
  @Environment(\.modelContext) private var modelContext

  @Query private var todos: [TodoItem]

  init(showCompleted: Bool) {
    let includeCompleted = showCompleted
    _todos = Query(
      filter: #Predicate<TodoItem> { todo in
        includeCompleted || todo.isCompleted == false
      },
      sort: \TodoItem.createdAt,
      order: .reverse
    )
  }

  var body: some View {
    Group {
      if todos.isEmpty {
        ContentUnavailableView(
          "タスクがありません",
          systemImage: "checklist",
          description: Text("右下の+から追加できます")
        )
      } else {
        List {
          ForEach(todos) { todo in
            HStack(alignment: .center, spacing: 12) {
              Button {
                todo.isCompleted.toggle()
              } label: {
                Image(systemName: todo.isCompleted ? "checkmark.circle.fill" : "circle")
                  .font(.title3)
                  .foregroundStyle(todo.isCompleted ? .green : .gray)
                  .frame(width: 28, height: 28)
                  .contentShape(Rectangle())
              }
              .buttonStyle(.plain)

              NavigationLink {
                TodoDetailView(todo: todo)
              } label: {
                VStack(alignment: .leading, spacing: 4) {
                  Text(todo.title)
                    .strikethrough(todo.isCompleted)
                    .foregroundStyle(todo.isCompleted ? .gray : .primary)
                  Text(
                    todo.createdAt.formatted(
                      .dateTime.year().month().day().locale(Locale(identifier: "ja_JP"))
                    )
                  )
                  .font(.caption)
                  .foregroundStyle(.secondary)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
              }
            }
          }
          .onDelete { indexSet in
            for index in indexSet {
              modelContext.delete(todos[index])
            }
          }
        }
        .scrollContentBackground(.hidden)
      }
    }
  }
}
