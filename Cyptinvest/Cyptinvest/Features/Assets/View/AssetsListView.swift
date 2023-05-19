//
//  AssetsListView.swift
//  Cyptinvest
//
//  Created by Glenn Ludszuweit on 17/05/2023.
//

import SwiftUI

struct AssetsListView: View {
    var body: some View {
        VStack {
            SearchBar(assetsViewModel: AssetsViewModel(manager: NetworkManager()))
            AssetsList(assetsViewModel: AssetsViewModel(manager: NetworkManager()))
        }
    }
}

struct AssetsListView_Previews: PreviewProvider {
    static var previews: some View {
        AssetsListView()
    }
}
