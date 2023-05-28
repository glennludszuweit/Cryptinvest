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
    @State var combinedAssets: [Asset] = []
    
    @Environment(\.managedObjectContext) private var viewContext
    
    var body: some View {
        List(combinedAssets) { asset in
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
            if userViewModel.assets.count == 0 {
                userViewModel.userAssets.forEach { item in
                    Task {
                        await assetViewModel.getCoinDetails("\(API.coingeckoGetCoinApi)\(item.id?.lowercased() ?? "bitcoin")\(API.coingeckoGetCoinApiQuery)")
                        if let assetDetail = assetViewModel.assetDetail {
                            userViewModel.assets.append(Asset(id: assetDetail.id ?? "", symbol: assetDetail.symbol ?? "", name: assetDetail.name ?? "", image: assetDetail.image?.thumb ?? "", currentPrice: assetDetail.marketData?.currentPrice?["usd"] ?? 0, priceChangePercentage24H: assetDetail.marketData?.priceChangePercentage24h, sparklineIn7D: assetDetail.marketData?.sparkLine7D, currentHoldings: item.amount))
                        }
                    }
                }
            }
            let items = userViewModel.assets + assetsViewModel.assets
            combinedAssets = items.reduce(into: [Asset]()) { result, element in
                if let index = result.firstIndex(where: { $0.id == element.id }) {
                    result[index].currentHoldings! += element.currentHoldings ?? 0
                } else {
                    result.append(element)
                }
            }
        }
    }
}

//struct AssetsList_Previews: PreviewProvider {
//    static var previews: some View {
//        AssetsList(assetsViewModel: AssetsViewModel(manager: NetworkManager()))
//    }
//}
