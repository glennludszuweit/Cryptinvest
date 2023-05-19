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
        VStack {
            HStack {
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
                        .foregroundColor(Color("OffBlack").opacity(0.8))
                        .font(.subheadline).fontWeight(.semibold)
                }
                Spacer()
                VStack {
                    HStack{
                        Spacer()
                        Text(asset.currentPrice.formatted(.currency(code: "USD")))
                            .foregroundColor(Color("OffBlack").opacity(0.8))
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
                        }.foregroundColor(asset.priceChangePercentage24H! >= 0.0 ? .green : .red)
                            .offset(y: -10)
                            .font(.custom("", size: 14))
                    }
                }
                
            }.padding(5)
                .padding(.bottom, -10)
                .frame(maxWidth: .infinity)
        }
        .onTapGesture {
            coordinator.assetDetails(asset: asset)
        }
        .listRowSeparator(.hidden)
    }
}
