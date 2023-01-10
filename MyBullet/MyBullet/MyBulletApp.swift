//
//  MyBulletApp.swift
//  MyBullet
//
//  Created by Roen White on 2023/01/10.
//

import SwiftUI

@main
struct MyBulletApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
          SignIn()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
