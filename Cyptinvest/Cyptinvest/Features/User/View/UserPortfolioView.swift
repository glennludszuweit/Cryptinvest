//
//  UserPortfolioView.swift
//  Cyptinvest
//
//  Created by Glenn Ludszuweit on 26/05/2023.
//

import SwiftUI

struct UserPortfolioView: View {
    @StateObject var userViewModel: UserViewModel
    @StateObject var assetViewModel: AssetDetailsViewModel
    @State var assets: [AssetDetail] = []
    @State var assetPrices: [Double] = []
    @State var assetsTotalWorth: Double = 0
    
    var body: some View {
        VStack {
            Text("\(assetsTotalWorth)")
        }.onAppear {
            userViewModel.userAssets.forEach { item in
                Task {
                    await assetViewModel.getCoinDetails("\(API.coingeckoGetCoinApi)\(item.id?.lowercased() ?? "bitcoin")\(API.coingeckoGetCoinApiQuery)")
                    if let assetDetail = assetViewModel.assetDetail {
                        assets.append(assetDetail)
                    }
                }
            }
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                assets.forEach { item in
                    if let currentUsd = item.marketData?.currentPrice?["usd"] {
                        assetPrices.append(currentUsd)
                    }
                }
                assetsTotalWorth = assetPrices.reduce(0.0) { $0 + $1 }
            }
        }
    }
}

//struct UserPortfolioView_Previews: PreviewProvider {
//    static var previews: some View {
//        UserPortfolioView(userViewModel: UserViewModel, assetViewModel: <#AssetDetailsViewModel#>)
//    }
//}
