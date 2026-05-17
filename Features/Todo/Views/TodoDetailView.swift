//
//  TodoDetailView.swift
//  Todo_data
//

import SwiftUI

struct TodoDetailView: View {
  @Bindable var todo: TodoItem
  @Bindable var viewModel: TodoDetailViewModel
  @Environment(\.dismiss) private var dismiss

  init(viewModel: TodoDetailViewModel) {
    self.viewModel = viewModel
    _todo = Bindable(viewModel.todo)
  }

  var body: some View {
    Form {
      Section("タスク情報") {
        TextField("タスク名", text: $todo.title)
        Toggle("完了済みにする", isOn: $todo.isCompleted)
      }

      Section("システム情報") {
        HStack {
          Text("作成日時")
          Spacer()
          Text(viewModel.formattedCreatedAt)
            .foregroundStyle(.secondary)
        }
      }

      Section {
        Button(role: .destructive) {
          viewModel.requestDelete()
        } label: {
          HStack {
            Spacer()
            Text("このタスクを削除")
            Spacer()
          }
        }
      }
    }
    .navigationTitle("タスク編集")
    .navigationBarTitleDisplayMode(.inline)
    .alert("本当に削除しますか？", isPresented: $viewModel.showDeleteAlert) {
      Button("削除", role: .destructive) {
        viewModel.confirmDelete()
        dismiss()
      }
      Button("キャンセル", role: .cancel) {
        viewModel.cancelDelete()
      }
    } message: {
      Text(viewModel.deleteConfirmationMessage)
    }
  }
}
