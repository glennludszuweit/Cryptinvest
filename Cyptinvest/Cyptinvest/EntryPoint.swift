//
//  EntryPoint.swift
//  Cyptinvest
//
//  Created by Glenn Ludszuweit on 18/05/2023.
//

import SwiftUI

struct EntryPoint: View {
    @EnvironmentObject var coordinator: Coordinator
    @StateObject var assetsViewModel: AssetsViewModel
    
    var body: some View {
        NavigationStack(path: $coordinator.navigationPath) {
            Header()
            CustomTabBar()
                .navigationDestination(for: CurrentPage.self) { navigation in
                    switch navigation {
                    case .assetsList:
                        AssetsListView(assetsViewModel: AssetsViewModel(manager: NetworkManager()))
                    case .assetDetails:
                        AssetDetailsView(asset: coordinator.asset)
                    }
                }
        }
    }
}

struct EntryPoint_Previews: PreviewProvider {
    static var previews: some View {
        EntryPoint(assetsViewModel: AssetsViewModel(manager: NetworkManager())).environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
