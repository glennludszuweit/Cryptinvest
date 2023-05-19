//
//  DetailsAdditionalInfo.swift
//  Cyptinvest
//
//  Created by Glenn Ludszuweit on 19/05/2023.
//

import SwiftUI

struct DetailsAdditionalInfo: View {
    @StateObject var assetViewModel: AssetViewModel
    var asset: Asset
    
    var body: some View {
        VStack {
            HStack {
                Text("Additional Information").font(.title).fontWeight(.bold)
                Spacer()
            }
            Divider()
            LazyVGrid(columns: [GridItem(.flexible())], alignment: .center, spacing: nil, pinnedViews: []) {
                Text(assetViewModel.assetDetail?.description?.en ?? "").foregroundColor(Color("OffBlack").opacity(0.75))
            }
        }.padding()
        .task {
            await assetViewModel.getCoinDetails("\(API.coingeckoGetCoinApi)\(asset.name.lowercased())\(API.coingeckoGetCoinApiQuery)")
        }
    }
}

struct DetailsAdditionalInfo_Previews: PreviewProvider {
    static var previews: some View {
        DetailsAdditionalInfo(assetViewModel: AssetViewModel(manager: NetworkManager()), asset: Asset(id: "test", symbol: "test", name: "test", image: "test", currentPrice: 0.0))
    }
}
