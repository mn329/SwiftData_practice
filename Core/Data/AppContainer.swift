//
//  Untitled.swift
//  Todo_data
//
//  Created by 石田湊 on 2026/05/01.
//

import Foundation
import SwiftData

    // 💡 構造体（カプセル）を作って、その中にデータベースの設定を閉じ込める
@MainActor
struct AppContainer {

        // 💡 static をつけることで、どこからでも安全に呼べる「共有の箱」にする
    static let shared: ModelContainer = {
        do {
            let schema = Schema([TodoItem.self])
            let config = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)
            return try ModelContainer(for: schema, configurations: [config])
        } catch {
            fatalError("データベースの初期化に失敗しました: \(error.localizedDescription)")
        }
    }()
}
