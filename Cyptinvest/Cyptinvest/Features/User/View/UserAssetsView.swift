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
    
    
    func percentageDifference(_ oldValue: Double, _ newValue: Double) -> Double {
        let difference = newValue - oldValue
        let percentageDifference = (difference / oldValue) * 100
        return percentageDifference
    }
    
    var body: some View {
        VStack {
            VStack {
                Text("\(userViewModel.assetsTotalWorth.formatted(.currency(code: "USD")))")
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
                userViewModel.populateUserAssetsList(assetViewModel: assetViewModel)
                userViewModel.calculateUsersWorth()
            }
        }
        .refreshable {
            if userViewModel.assets.count == 0 {
                userViewModel.populateUserAssetsList(assetViewModel: assetViewModel)
                userViewModel.calculateUsersWorth()
            }
        }
        .navigationTitle("Portfolio")
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                    HStack {
                        Text(String(format:"%.2f %@", percentageDifference(10000, userViewModel.assetsTotalWorth), "%").replacingOccurrences(of: "-", with: ""))
                        Image(systemName: userViewModel.assetsTotalWorth >= 10000 ? "arrowtriangle.up.fill" : "arrowtriangle.down.fill")
                            .resizable()
                            .frame(width: 10, height: 10)
                    }.foregroundColor(userViewModel.assetsTotalWorth >= 10000 ? Color("Green") : Color("Red"))
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
