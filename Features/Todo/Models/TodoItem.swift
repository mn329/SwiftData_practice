    //
    //  TodoItem.swift
    //  Todo_data
    //
    //  Created by 石田湊 on 2026/05/01.
    //

import Foundation
import SwiftData // 💡 データベースのモデルにするために必須

    // 💡 1. クラスの先頭に @Model をつける
@Model
final class TodoItem {
        // 💡 2. データベースの「カラム（列）」になるプロパティを定義
    var id: UUID
    var title: String
    var isCompleted: Bool
    var createdAt: Date = Date()  // タスクの作成日時（初期値は現在日時）

        // 💡 3. 初期化処理（イニシャライザ）
    init(id: UUID = UUID(), title: String, isCompleted: Bool = false, createdAt: Date = Date()) {
        self.id = id
        self.title = title
        self.isCompleted = isCompleted
        self.createdAt = createdAt
    }
}
