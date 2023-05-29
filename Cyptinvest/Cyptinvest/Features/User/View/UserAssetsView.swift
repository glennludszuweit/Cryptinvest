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
    
    func populateUserAssetsList() {
        userViewModel.userAssets.forEach { item in
            Task {
                await assetViewModel.getCoinDetails("\(API.coingeckoGetCoinApi)\(item.id?.lowercased() ?? "bitcoin")\(API.coingeckoGetCoinApiQuery)")
                if let assetDetail = assetViewModel.assetDetail {
                    userViewModel.assets.append(Asset(id: assetDetail.id ?? "", symbol: assetDetail.symbol ?? "", name: assetDetail.name ?? "", image: assetDetail.image?.thumb ?? "", currentPrice: assetDetail.marketData?.currentPrice?["usd"] ?? 0, marketCap: assetDetail.marketData?.marketCap?["usd"], fullyDilutedValuation: assetDetail.marketData?.fullyDilutedValuation?["usd"], totalVolume: assetDetail.marketData?.totalVolume?["usd"], priceChangePercentage24H: assetDetail.marketData?.priceChangePercentage24h, circulatingSupply: assetDetail.marketData?.circulatingSupply, totalSupply: assetDetail.marketData?.totalSupply, maxSupply: assetDetail.marketData?.maxSupply, sparklineIn7D: assetDetail.marketData?.sparkLine7D, currentHoldings: item.amount))
                }
            }
        }
    }
    
    func calculateUsersWorth() {
        DispatchQueue.main.asyncAfter (deadline: .now() + 1) {
            userViewModel.assets.forEach { item in
                assetPrices.append(item.currentPrice * (item.currentHoldings ?? 0))
            }
            assetsTotalWorth = assetPrices.reduce(0.0) { $0 + $1 } + (userViewModel.userData.first?.usd ?? 0)
        }
    }
    
    var body: some View {
        VStack {
            VStack {
                Text("\(assetsTotalWorth.formatted(.currency(code: "USD")))")
                    .foregroundColor(Color("Purple").opacity(0.75))
                    .font(.custom("", size: 35))
                    .fontWeight(.semibold)
                    .frame(maxWidth: .infinity, maxHeight: 100)
            }
            USDCell(amount: userViewModel.userData.first?.usd ?? 0)
            List(userViewModel.assets) { asset in
                AssetsListCell(asset: asset)
            }
            .listStyle(.plain)
            .frame( maxWidth: .infinity)
            .ignoresSafeArea()
            .scrollContentBackground(.hidden)
        }
        .onAppear {
            if userViewModel.assets.count == 0 {
                populateUserAssetsList()
                calculateUsersWorth()
            }
        }
        .refreshable {
            if userViewModel.assets.count == 0 {
                populateUserAssetsList()
                calculateUsersWorth()
            }
        }
        .navigationTitle("Portfolio")
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                    HStack {
                        Text(String(format:"%.2f %@", percentageDifference(10000, assetsTotalWorth), "%").replacingOccurrences(of: "-", with: ""))
                        Image(systemName: assetsTotalWorth >= 10000 ? "arrowtriangle.up.fill" : "arrowtriangle.down.fill")
                            .resizable()
                            .frame(width: 10, height: 10)
                    }.foregroundColor(assetsTotalWorth >= 10000 ? Color("Green") : Color("Red"))
                        .font(.custom("", size: 16))
            }
        }
    }
}

//struct UserPortfolioView_Previews: PreviewProvider {
//    static var previews: some View {
//        UserPortfolioView(userViewModel: UserViewModel, assetViewModel: <#AssetDetailsViewModel#>)
//    }
//}
