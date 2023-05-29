//
//  DetailsOverview.swift
//  Cyptinvest
//
//  Created by Glenn Ludszuweit on 19/05/2023.
//

import SwiftUI

struct DetailsOverview: View {
    var asset: Asset
    var columns: [GridItem] = [
        GridItem(.flexible()),
        GridItem(.flexible()),
    ]
    
    var body: some View {
        VStack {
            HStack {
                Text("Overview").font(.title).fontWeight(.bold)
                Spacer()
            }
            Divider()
            LazyVGrid(columns: columns, alignment: .leading, spacing: nil, pinnedViews: []) {
                DetailsStats(title: "Market Cap:", data: (asset.marketCap?.formatted(.currency(code: "USD"))) ?? "")
                DetailsStats(title: "Trading Volume:", data: (asset.totalVolume?.formatted(.currency(code: "USD"))) ?? "")
                DetailsStats(title: "Fully Diluted Valuation:", data: (asset.fullyDilutedValuation?.formatted(.currency(code: "USD"))) ?? "")
                DetailsStats(title: "Circulating Supply:", data: (asset.circulatingSupply?.formatted(.currency(code: "USD"))) ?? "")
                DetailsStats(title: "Total Supply:", data: (asset.totalSupply?.formatted(.currency(code: "USD"))) ?? "")
                DetailsStats(title: "Max Supply:", data: (asset.maxSupply?.formatted(.currency(code: "USD"))) ?? "")
            }
        }.padding()
    }
}

struct DetailsOverview_Previews: PreviewProvider {
    static var previews: some View {
        DetailsOverview(asset: Asset(id: "test", symbol: "test", name: "test", image: "test", currentPrice: 0.0, priceChange24H: 0.0))
    }
}
