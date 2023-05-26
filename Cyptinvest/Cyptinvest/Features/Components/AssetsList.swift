//
//  AssetsList.swift
//  Cyptinvest
//
//  Created by Glenn Ludszuweit on 19/05/2023.
//

import SwiftUI

struct AssetsList: View {
    @StateObject var assetsViewModel: AssetsViewModel
    
    var body: some View {
        List(assetsViewModel.assets) { asset in
            AssetsListCell(asset: asset)
        }
        .listStyle(.plain)
        .offset(y: -10)
        .padding(.top, -10)
        .frame( maxWidth: .infinity)
        .ignoresSafeArea()
//        .edgesIgnoringSafeArea(.leading)
//        .edgesIgnoringSafeArea(.trailing)
        .scrollContentBackground(.hidden)
        .task {
            await assetsViewModel.getMarketAssets()
        }
    }
}

struct AssetsList_Previews: PreviewProvider {
    static var previews: some View {
        AssetsList(assetsViewModel: AssetsViewModel(manager: NetworkManager()))
    }
}
