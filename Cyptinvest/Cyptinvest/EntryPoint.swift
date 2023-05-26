//
//  EntryPoint.swift
//  Cyptinvest
//
//  Created by Glenn Ludszuweit on 18/05/2023.
//

import SwiftUI

struct EntryPoint: View {
    @EnvironmentObject var coordinator: Coordinator
    @Environment(\.managedObjectContext) private var viewContext
    
    var body: some View {
        NavigationStack(path: $coordinator.navigationPath) {
            LaunchView(userViewModel: UserViewModel(manager: CoreDataManager(context: viewContext), context: viewContext)).edgesIgnoringSafeArea(.all).offset(y: 150)
//            CustomTabBar()
                .navigationDestination(for: CurrentPage.self) { navigation in
                    switch navigation {
                    case .assetsList:
                        CustomTabBar()
                    case .assetDetails:
                        AssetDetailsView(asset: coordinator.asset)
                    }
                }
        }
    }
}

struct EntryPoint_Previews: PreviewProvider {
    static var previews: some View {
        EntryPoint().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
