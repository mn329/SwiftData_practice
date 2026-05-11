import SwiftData
import SwiftUI

struct TodoDetailView: View {
    @Bindable var todo: TodoItem
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) private var dismiss
    @State private var showDeleteAlert = false
    
    var body: some View {

        // 💡 1. Formを使うことで、iOS標準の美しい設定画面のようなUIが作られます
        Form {
                // 💡 2. Sectionを使って、関連する項目を視覚的にグループ化します
            Section("タスク情報") {
                TextField("タスク名", text: $todo.title)
                
                    // 💡 3. 完了状態も @Bindable の恩恵で直接バインディング！
                Toggle("完了済みにする", isOn: $todo.isCompleted)
            }
            
            Section("システム情報") {
                    // 💡 4. 作成日時は編集させないので、バインディング($)なしで表示のみ行う
                HStack {
                    Text("作成日時")
                    Spacer()
                    Text(todo.createdAt.formatted(.dateTime.year().month().day().locale(Locale(identifier: "ja_JP"))))
                        .foregroundStyle(.secondary)
                }
            }
            Section {
                    // 💡 3. role（役割）に .destructive（破壊的）を指定する
                Button(role: .destructive) {
                    showDeleteAlert = true
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
        .alert("本当に削除しますか？", isPresented: $showDeleteAlert) {
            Button("削除", role: .destructive) {
                modelContext.delete(todo)
                dismiss()
            }
            Button("キャンセル", role: .cancel) {
                showDeleteAlert = false
            }
        } message: {
            Text("「\(todo.title)」を本当に削除しますか？\nこの操作は取り消せません。")
        }
    }
}
