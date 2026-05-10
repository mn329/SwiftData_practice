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
    Button(action: action) {
      Image(systemName: "plus")
    }
    .buttonStyle(.glass)
    .tint(Color.blue.opacity(0.7))
  }
}

// 状態と全体 UI を持つ親 View
struct TodoView: View {
  @State private var isAddSheetPresented = false
  @State private var showCompleted = true

  var body: some View {
    NavigationStack {
      VStack(spacing: 0) {
        Toggle("完了済みタスクを表示", isOn: $showCompleted)
          .padding()

        FilteredTodoListView(showCompleted: showCompleted)
          .id(showCompleted)
      }
      .frame(maxWidth: .infinity, maxHeight: .infinity)
      .background(
        LinearGradient(
          colors: [
            Color.blue.opacity(0.20),
            Color.purple.opacity(0.14),
            Color(.systemBackground),
          ],
          startPoint: .topLeading,
          endPoint: .bottomTrailing
        )
      )
      .navigationTitle("Todo")
      .navigationBarTitleDisplayMode(.inline)
      .overlay(alignment: .bottomTrailing) {
        AddTodoButton {
          isAddSheetPresented = true
        }
        .padding(.trailing, 20)
        .padding(.bottom, 20)
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
