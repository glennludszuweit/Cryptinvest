//
//  AssetDetailsView.swift
//  Cyptinvest
//
//  Created by Glenn Ludszuweit on 17/05/2023.
//

import SwiftUI

struct AssetDetailsView: View {
    var asset: Asset
    
    var body: some View {
        ScrollView {
            DetailsHeader(asset: asset)
            TransactionButtons()
            DetailsOverview(asset: asset)
            DetailsAdditionalInfo(assetViewModel: AssetViewModel(manager: NetworkManager()), asset: asset)
        }
    }
}

struct AssetDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        AssetDetailsView(asset: Asset(id: "test", symbol: "test", name: "test", image: "test", currentPrice: 0.0))
    }
}
