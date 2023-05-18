//
//  AssetsListView.swift
//  Cyptinvest
//
//  Created by Glenn Ludszuweit on 17/05/2023.
//

import SwiftUI

struct AssetsListView: View {
    @StateObject var assetsViewModel: AssetsViewModel
    
    var body: some View {
        VStack {
            SearchBar(assetsViewModel: assetsViewModel)
            List(assetsViewModel.assets) { asset in
                AssetsListCell(asset: asset)
            }
            .listStyle(.plain)
            .offset(y: -10)
            .padding(.top, -10)
            .frame( maxWidth: .infinity)
            .edgesIgnoringSafeArea(.leading)
            .edgesIgnoringSafeArea(.trailing)
            .scrollContentBackground(.hidden)
            .task {
                await assetsViewModel.getAll()
            }
        }
    }
}

struct AssetsListView_Previews: PreviewProvider {
    static var previews: some View {
        AssetsListView(assetsViewModel: AssetsViewModel(manager: NetworkManager()))
    }
}
