//
//  TodoItem+Formatting.swift
//  Todo_data
//

import Foundation

extension TodoItem {
  var createdAtFormatted: String {
    createdAt.formatted(
      .dateTime.year().month().day().locale(Locale(identifier: "ja_JP"))
    )
  }
}
