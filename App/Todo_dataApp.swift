    //
    //  Todo_dataApp.swift
    //  Todo_data
    //
    //  Created by 石田湊 on 2026/05/01.
    //

import SwiftUI
import SwiftData

@main
struct Todo_dataApp: App {
    var body: some Scene {
        WindowGroup {
            TodoView()
        }
        .modelContainer(AppContainer.shared)
    }
}
