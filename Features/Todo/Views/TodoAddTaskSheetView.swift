//
//  TodoAddTaskSheetView.swift
//  Todo_data
//

import SwiftUI

struct TodoAddTaskSheetView: View {
  @Bindable var viewModel: TodoAddTaskSheetViewModel
  @Environment(\.dismiss) private var dismiss

  var body: some View {
    NavigationStack {
      VStack {
        Spacer()
        VStack(alignment: .center, spacing: 12) {
          TextField("タスクを入力", text: $viewModel.draftTaskTitle)
            .textFieldStyle(.roundedBorder)
            .multilineTextAlignment(.center)
          Text("入力中: \(viewModel.inputPreview)")
            .font(.caption)
            .foregroundStyle(.secondary)
            .multilineTextAlignment(.center)
        }
        .frame(maxWidth: .infinity)
        Spacer()
      }
      .frame(maxWidth: .infinity, maxHeight: .infinity)
      .padding()
      .navigationTitle("タスク追加")
      .navigationBarTitleDisplayMode(.inline)
      .toolbar {
        ToolbarItem(placement: .cancellationAction) {
          Button("戻る", role: .cancel) {
            viewModel.resetDraft()
            dismiss()
          }
        }
        ToolbarItem(placement: .confirmationAction) {
          Button("追加") {
            if viewModel.submit() {
              dismiss()
            }
          }
          .disabled(!viewModel.canSubmit)
        }
      }
    }
  }
}
