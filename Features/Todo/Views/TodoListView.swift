//
//  ContentView.swift
//  Todo_data
//
//  Created by 石田湊 on 2026/05/01.
//

import SwiftData
import SwiftUI

struct AddTodoButton: View {
  let action: () -> Void
  var body: some View {
    Button(action: action) { Image(systemName: "plus") }.buttonStyle(.borderedProminent)
  }
}

struct TodoView: View {
  // 💡 2. SwiftDataのデータベースを操作するための環境変数
  @Environment(\.modelContext) private var modelContext
  // 💡 3. SwiftDataのデータベースからデータを取得するためのクエリ
  @Query(sort: \TodoItem.createdAt, order: .forward) private var todos: [TodoItem]
  @State private var isAddSheetPresented = false

  var body: some View {
    NavigationStack {
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
              HStack {
                Image(systemName: todo.isCompleted ? "checkmark.circle.fill" : "circle")
                  .foregroundStyle(todo.isCompleted ? .green : .gray)
                  .onTapGesture {
                    todo.isCompleted.toggle()
                  }
                VStack(alignment: .leading) {
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
              }
            }
            .onDelete { indexSet in
              for index in indexSet {
                modelContext.delete(todos[index])
              }
            }
          }
        }
      }
      .frame(maxWidth: .infinity, maxHeight: .infinity)
      .background(Color(.systemBackground))
      .navigationTitle("Todo")
      .navigationBarTitleDisplayMode(.inline)
      .overlay(alignment: .bottomTrailing) {
        AddTodoButton {
          isAddSheetPresented = true
        }.padding(.trailing, 20).padding(.bottom, 20)
      }
      .sheet(isPresented: $isAddSheetPresented) {
        TodoAddTaskSheetView()
      }
    }
  }
}

#Preview {
  let container: ModelContainer = {
    do {
      let schema = Schema([TodoItem.self])
      let config = ModelConfiguration(schema: schema, isStoredInMemoryOnly: true)
      let c = try ModelContainer(for: schema, configurations: [config])
      c.mainContext.insert(TodoItem(title: "シミュレータ確認用"))
      return c
    } catch {
      fatalError(String(describing: error))
    }
  }()
  return TodoView()
    .modelContainer(container)
}
