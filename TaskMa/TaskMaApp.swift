//
//  TaskMaApp.swift
//  TaskMa
//
//  Created by Isaias Cuvula on 11.03.22.
//

import SwiftUI



@main
struct TaskMaApp: App {
    
    @StateObject var viewModel = TaskViewModel()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(viewModel)
        }
    }
}
