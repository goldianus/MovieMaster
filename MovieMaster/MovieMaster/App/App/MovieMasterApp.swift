//
//  MovieMasterApp.swift
//  MovieMaster
//
//  Created by Goldianus Solangius on 02/11/24.
//

import SwiftUI
import SwiftData

// @main
// struct MovieMasterApp: App {
//    var sharedModelContainer: ModelContainer = {
//        let schema = Schema([
//            Item.self,
//        ])
//        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)
//
//        do {
//            return try ModelContainer(for: schema, configurations: [modelConfiguration])
//        } catch {
//            fatalError("Could not create ModelContainer: \(error)")
//        }
//    }()
//
//    var body: some Scene {
//        WindowGroup {
//            ContentView()
//        }
//        .modelContainer(sharedModelContainer)
//    }
// }

@main
struct MovieMasterApp: App {
  var body: some Scene {
    WindowGroup {
      TabViewController()
    }
  }
}
