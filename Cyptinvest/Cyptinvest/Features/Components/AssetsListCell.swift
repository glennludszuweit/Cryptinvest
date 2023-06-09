//
//  ListCell.swift
//  Cyptinvest
//
//  Created by Glenn Ludszuweit on 18/05/2023.
//

import SwiftUI

struct AssetsListCell: View {
    @EnvironmentObject var coordinator: Coordinator
    var asset: Asset
    
    var body: some View {
        HStack {
            DisplayAssetName()
            DisplayHoldingsValue()
            DisplayPrice()
        }.padding(5)
            .padding(.bottom, -10)
            .frame(maxWidth: .infinity)
            .onTapGesture {
                coordinator.assetDetails(asset: asset)
            }
            .listRowSeparator(.hidden)
    }
    
    @ViewBuilder
    func DisplayAssetName() -> some View {
        Group {
            AsyncImage(url: URL(string: asset.image)) {
                phase in
                if let image = phase.image {
                    image
                        .resizable()
                        .scaledToFit()
                        .frame(width: 30, height: 30)
                        .padding(.trailing, 2)
                } else if phase.error != nil {
                    ProgressView().onAppear{
                        print(ErrorHandler.imageDoesNotExist.errorDescription!)
                        
                    }
                } else {
                    ProgressView()
                }
            }
            Text(asset.symbol.uppercased())
                .foregroundColor(Color("Black").opacity(0.8))
                .font(.subheadline).fontWeight(.semibold)
        }
    }
    
    @ViewBuilder
    func DisplayHoldingsValue() -> some View {
        VStack {
            if asset.currentHoldings ?? 0 > 0 {
                HStack{
                    Spacer()
                    Text(asset.currentHoldingsValue.formatted(.currency(code: "USD")))
                        .foregroundColor(Color("Black").opacity(0.8))
                        .font(.subheadline)
                        .fontWeight(.semibold)
                }
            }
        }
    }
    
    @ViewBuilder
    func DisplayPrice() -> some View {
        VStack {
            HStack{
                Spacer()
                Text(asset.currentPrice.formatted(.currency(code: "USD")))
                    .foregroundColor(Color("Black").opacity(0.8))
                    .font(.subheadline)
                    .fontWeight(.semibold)
            }
            HStack {
                Spacer()
                Group {
                    Text(String(format:"%.2f %@", asset.priceChangePercentage24H!, "%").replacingOccurrences(of: "-", with: ""))
                    Image(systemName: asset.priceChangePercentage24H! >= 0.0 ? "arrowtriangle.up.fill" : "arrowtriangle.down.fill")
                        .resizable()
                        .frame(width: 10, height: 10)
                }.foregroundColor(asset.priceChangePercentage24H! >= 0.0 ? Color("Green") : Color("Red"))
                    .offset(y: -10)
                    .font(.custom("", size: 14))
            }
        }
    }
}
