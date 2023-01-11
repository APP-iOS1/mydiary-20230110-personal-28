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
    
    @StateObject var signInVM = SignInViewModel()
    
    init() {
        FirebaseApp.configure()
    }

    var body: some Scene {
        WindowGroup {
          ContentView()
                .environmentObject(signInVM)
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
