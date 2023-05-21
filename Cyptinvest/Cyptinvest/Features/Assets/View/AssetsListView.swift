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
            AssetsList(assetsViewModel: assetsViewModel)
        }
    }
}

struct AssetsListView_Previews: PreviewProvider {
    static var previews: some View {
        AssetsListView(assetsViewModel: AssetsViewModel(manager: NetworkManager()))
    }
}
