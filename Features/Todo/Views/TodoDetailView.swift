import SwiftData
import SwiftUI

struct TodoDetailView: View {
  @Bindable var todo: TodoItem

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
    }
    .navigationTitle("タスク編集")
    .navigationBarTitleDisplayMode(.inline)
  }
}