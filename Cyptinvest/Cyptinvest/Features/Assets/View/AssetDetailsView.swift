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
            DetailsChart(asset: asset)
            TransactionButtons(asset: asset)
            DetailsOverview(asset: asset)
            DetailsAdditionalInfo(assetViewModel: AssetDetailsViewModel(manager: NetworkManager()), asset: asset)
        }
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                HStack {
                    Text(asset.symbol.uppercased()).fontWeight(.semibold).foregroundColor(Color("Black")).font(.headline)
                    AsyncImage(url: URL(string: asset.image)) {
                        phase in
                        if let image = phase.image {
                            image
                                .resizable()
                                .scaledToFit()
                                .frame(width: 25, height: 25)
                        } else if phase.error != nil {
                            ProgressView().onAppear{
                                print(ErrorHandler.imageDoesNotExist.errorDescription!)
                                
                            }
                        } else {
                            ProgressView()
                        }
                    }
                }
            }
        }
    }
}

struct AssetDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        AssetDetailsView(asset: Asset(id: "test", symbol: "test", name: "test", image: "test", currentPrice: 0.0))
    }
}
