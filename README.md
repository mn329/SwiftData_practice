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
| `Features/Todo/Models/TodoItem+Formatting.swift` | 表示用フォーマット（作成日時など） |
| `Features/Todo/Services/TodoRepository.swift` | SwiftData への読み書き（データアクセス層） |
| `Features/Todo/ViewModels/*.swift` | 画面の状態・操作ロジック（MVVM の VM） |
| `Features/Todo/Views/TodoListView.swift` | 一覧画面の UI（`TodoView`） |
| `Features/Todo/Views/FilteredTodoListView.swift` | フィルタ付き一覧 UI |
| `Features/Todo/Views/TodoDetailView.swift` | タスク編集 UI |
| `Features/Todo/Views/TodoAddTaskSheetView.swift` | 追加シート UI |

## アーキテクチャ（MVVM）

| 層 | ファイル例 | 責務 |
|----|-----------|------|
| **View** | `TodoListView.swift` など | レイアウト・ユーザー操作の受け口 |
| **ViewModel** | `TodoListViewModel.swift` など | 画面状態・バリデーション・操作の委譲 |
| **Repository** | `TodoRepository.swift` | `modelContext` 経由の永続化 |
| **Model** | `TodoItem.swift` | データ定義（`@Model`） |

- UI: SwiftUI（`@Query` は一覧 View で DB 変更を自動反映）
- 永続化: SwiftData
- View は `ViewModel` 経由で `TodoRepository` にアクセスし、直接 `modelContext` を触らない

## ライセンス

特に指定がない限り、リポジトリ管理者の方針に従います。

---
