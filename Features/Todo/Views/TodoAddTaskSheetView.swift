//
//  TodoAddTaskSheetView.swift
//  Todo_data
//

import SwiftData
import SwiftUI

/// タスク追加用シート（入力欄・ツールバー・保存処理をまとめる）
struct TodoAddTaskSheetView: View {
  @State private var draftTaskTitle = ""
  // 閉じるボタンを押した時に空にする
  @Environment(\.dismiss) private var dismiss
  @Environment(\.modelContext) private var modelContext

  var body: some View {
    NavigationStack {
      VStack {
        Spacer()
        VStack(alignment: .center, spacing: 12) {
          TextField("タスクを入力", text: $draftTaskTitle)
            .textFieldStyle(.roundedBorder)
            .multilineTextAlignment(.center)
          Text("入力中: \(draftTaskTitle)")
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
            draftTaskTitle = ""
            dismiss()
          }
        }
        ToolbarItem(placement: .confirmationAction) {
          Button("追加") {
            // 空白をtrimしてから追加
            let trimmedTitle =
              draftTaskTitle.trimmingCharacters(in: .whitespacesAndNewlines)
            guard !trimmedTitle.isEmpty else {
              return
            }
            modelContext.insert(TodoItem(title: trimmedTitle))
            draftTaskTitle = ""
            dismiss()
          }
          .disabled(
            draftTaskTitle.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
          )
        }
      }
    }
  }
}
