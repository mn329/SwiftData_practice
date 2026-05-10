# Todo_data

SwiftUI と SwiftData を使ったシンプルな Todo アプリの学習用プロジェクトです。

## できること

- Todo の一覧表示（`createdAt` が新しい順）
- 右下の **+** からシートを開き、タイトルを入力して追加
- タップで完了／未完了の切り替え
- スワイプで削除
- データは `AppContainer` 経由で永続化（アプリ終了後も保持）

## 要件

- Xcode（SwiftData を利用できるバージョン）
- プロジェクトのデプロイターゲット: iOS 26.0（`project.pbxproj` の設定に準拠）

## 開き方・ビルド

1. リポジトリをクローンする
2. `Todo_data.xcodeproj` を Xcode で開く
3. シミュレータまたは実機を選び、**Run**（⌘R）

## プロジェクト構成（主要ファイル）

| パス | 役割 |
|------|------|
| `App/Todo_dataApp.swift` | エントリ。`TodoView` を表示し `modelContainer` を注入 |
| `Core/Data/AppContainer.swift` | `ModelContainer` の共有設定（スキーマ・永続化） |
| `Features/Todo/Models/TodoItem.swift` | `@Model` のデータモデル |
| `Features/Todo/Views/TodoListView.swift` | 一覧・追加シート・操作 UI（`TodoView` など） |
| `Features/Todo/Views/FilteredTodoListView.swift` | フィルタ付き一覧（`NavigationLink` で詳細へ） |
| `Features/Todo/Views/TodoDetailView.swift` | タスク名の編集（`@Bindable`） |
| `Features/Todo/Views/TodoAddTaskSheetView.swift` | 追加シート |

## アーキテクチャのメモ

- UI: SwiftUI
- 永続化: SwiftData（`@Model` / `@Query` / `modelContext`）
- 画面ロジックは MVVM を意識した分割（View とモデル・コンテナの役割分離）

## ライセンス

特に指定がない限り、リポジトリ管理者の方針に従います。

---
