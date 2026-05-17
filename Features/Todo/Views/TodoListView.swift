//
//  TodoListView.swift
//  Todo_data
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

struct TodoView: View {
  @Environment(\.modelContext) private var modelContext
  @State private var viewModel = TodoListViewModel()
  @State private var filteredListViewModel: FilteredTodoListViewModel?

  var body: some View {
    NavigationStack {
      VStack(spacing: 0) {
        Toggle("完了済みタスクを表示", isOn: $viewModel.showCompleted)
          .padding()

        if let filteredListViewModel {
          FilteredTodoListView(
            filter: viewModel.filter,
            viewModel: filteredListViewModel
          )
          .id(viewModel.listIdentity)
        }
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
      .searchable(text: $viewModel.searchText, prompt: "タスクを検索")
      .navigationBarTitleDisplayMode(.inline)
      .overlay(alignment: .bottomTrailing) {
        AddTodoButton {
          viewModel.presentAddSheet()
        }
        .padding(.trailing, 20)
        .padding(.bottom, 20)
      }
      .sheet(isPresented: $viewModel.isAddSheetPresented) {
        TodoAddTaskSheetView(
          viewModel: TodoAddTaskSheetViewModel(
            repository: TodoRepository(modelContext: modelContext)
          )
        )
      }
      .onAppear {
        if filteredListViewModel == nil {
          filteredListViewModel = FilteredTodoListViewModel(
            repository: TodoRepository(modelContext: modelContext)
          )
        }
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
