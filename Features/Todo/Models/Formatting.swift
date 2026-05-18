//
//  Formatting.swift
//  Todo_data
//

import Foundation

// TodoItem の表示用プロパティ（DB には保存しない計算プロパティ）
extension TodoItem {
  var createdAtFormatted: String {
    createdAt.formatted(
      .dateTime.year().month().day().locale(Locale(identifier: "ja_JP"))
    )
  }
}
