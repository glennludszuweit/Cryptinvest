//
//  CyptinvestApp.swift
//  Cyptinvest
//
//  Created by Glenn Ludszuweit on 16/05/2023.
//

import SwiftUI

@main
struct CyptinvestApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            EntryPoint(assetsViewModel: AssetsViewModel(manager: NetworkManager()))
                .environment(\.managedObjectContext, persistenceController.container.viewContext).environmentObject(Coordinator())
        }
    }
}
