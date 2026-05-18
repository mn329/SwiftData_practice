//
//  AppContainer.swift
//  Todo_data
//

import Foundation
import SwiftData

// アプリ全体で共有する SwiftData の ModelContainer
@MainActor
struct AppContainer {

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

