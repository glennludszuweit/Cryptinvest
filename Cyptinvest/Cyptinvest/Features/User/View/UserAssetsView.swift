//
//  UserAssetsView.swift
//  Cyptinvest
//
//  Created by Glenn Ludszuweit on 26/05/2023.
//

import SwiftUI

struct UserAssetsView: View {
    @StateObject var userViewModel: UserViewModel
    @StateObject var assetViewModel: AssetDetailsViewModel
    @State var assetPrices: [Double] = []
    @State var assetsTotalWorth: Double = 10000
    
    func percentageDifference(_ oldValue: Double, _ newValue: Double) -> Double {
        let difference = newValue - oldValue
        let percentageDifference = (difference / oldValue) * 100
        return percentageDifference
    }
    
    var body: some View {
        VStack {
            VStack {
                Text("\(assetsTotalWorth.formatted(.currency(code: "USD")))")
                    .foregroundColor(Color("Purple").opacity(0.75))
                    .font(.custom("", size: 35))
                    .fontWeight(.semibold)
                    .frame(maxWidth: .infinity, maxHeight: 150)
            }
            Divider().frame(height: 1).background(Color("Purple")).shadow(color: Color("Black").opacity(0.2), radius: 10)
//            List {
            USDCell(amount: userViewModel.userData.first?.usd ?? 0)
//            }
            List(userViewModel.assets) { asset in
                AssetsListCell(asset: asset)
            }
            .listStyle(.plain)
//            .offset(y: -10)
//            .padding(.top, -10)
            .frame( maxWidth: .infinity)
            .ignoresSafeArea()
            //        .edgesIgnoringSafeArea(.leading)
            //        .edgesIgnoringSafeArea(.trailing)
            .scrollContentBackground(.hidden)
        }
        .onAppear {
            if userViewModel.assets.count == 0 {
                userViewModel.userAssets.forEach { item in
                    Task {
                        await assetViewModel.getCoinDetails("\(API.coingeckoGetCoinApi)\(item.id?.lowercased() ?? "bitcoin")\(API.coingeckoGetCoinApiQuery)")
                        if let assetDetail = assetViewModel.assetDetail {
                            userViewModel.assets.append(Asset(id: assetDetail.id ?? "", symbol: assetDetail.symbol ?? "", name: assetDetail.name ?? "", image: assetDetail.image?.thumb ?? "", currentPrice: assetDetail.marketData?.currentPrice?["usd"] ?? 0, priceChangePercentage24H: assetDetail.marketData?.priceChangePercentage24h, sparklineIn7D: assetDetail.marketData?.sparkLine7D, currentHoldings: item.amount))
                        }
                    }
                }
                
                DispatchQueue.main.asyncAfter (deadline: .now() + 1) {
                    userViewModel.assets.forEach { item in
                        assetPrices.append(item.currentPrice * (item.currentHoldings ?? 0))
                    }
                    assetsTotalWorth = assetPrices.reduce(0.0) { $0 + $1 } + (userViewModel.userData.first?.usd ?? 0)
                    print(assetsTotalWorth)
                    
                }
            }
        }
    }
}

//struct UserPortfolioView_Previews: PreviewProvider {
//    static var previews: some View {
//        UserPortfolioView(userViewModel: UserViewModel, assetViewModel: <#AssetDetailsViewModel#>)
//    }
//}
