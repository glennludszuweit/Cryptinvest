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
                AsyncImage(url: URL(string: asset.image)) {
                    phase in
                    if let image = phase.image {
                        image
                            .resizable()
                            .scaledToFit()
                            .frame(width: 30, height: 30)
                            .padding(.trailing, 10)
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
                    .fontWeight(.semibold)
                Spacer()
            }.padding(10)
                .frame(maxWidth: .infinity)
                .onTapGesture {
                    coordinator.assetDetails()
                }
        }
        .listRowSeparator(.hidden)
    }
}
