//
//  MyBulletApp.swift
//  MyBullet
//
//  Created by Roen White on 2023/01/10.
//

import SwiftUI
import FirebaseCore

@main
struct MyBulletApp: App {
    let persistenceController = PersistenceController.shared
    
    @StateObject var authManager = AuthManager()
    
    init() {
        FirebaseApp.configure()
    }

    var body: some Scene {
        WindowGroup {
          ContentView()
                .environmentObject(authManager)
//                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
