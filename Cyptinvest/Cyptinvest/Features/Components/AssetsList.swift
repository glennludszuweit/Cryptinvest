//
//  AssetsList.swift
//  Cyptinvest
//
//  Created by Glenn Ludszuweit on 19/05/2023.
//

import SwiftUI

struct AssetsList: View {
    @StateObject var assetsViewModel: AssetsViewModel
    @StateObject var userViewModel: UserViewModel
    @StateObject var assetViewModel: AssetDetailsViewModel
    
    @Environment(\.managedObjectContext) private var viewContext
    
    
    
    var body: some View {
        List(assetsViewModel.combinedAssets) { asset in
            AssetsListCell(asset: asset)
        }
        .listStyle(.plain)
        .offset(y: -10)
        .padding(.top, -10)
        .frame( maxWidth: .infinity)
        .ignoresSafeArea()
        .scrollContentBackground(.hidden)
        .task {
            await assetsViewModel.getMarketAssets()
            assetsViewModel.addAndReduceUserAssetsWithApiResult(userViewModel: userViewModel, assetViewModel: assetViewModel)
        }
        .refreshable {
            await assetsViewModel.getMarketAssets()
            assetsViewModel.addAndReduceUserAssetsWithApiResult(userViewModel: userViewModel, assetViewModel: assetViewModel)
        }
    }
}

//struct AssetsList_Previews: PreviewProvider {
//    static var previews: some View {
//        AssetsList(assetsViewModel: AssetsViewModel(manager: NetworkManager()))
//    }
//}
