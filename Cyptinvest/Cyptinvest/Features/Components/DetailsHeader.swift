//
//  DetailsHeader.swift
//  Cyptinvest
//
//  Created by Glenn Ludszuweit on 19/05/2023.
//

import SwiftUI

struct DetailsHeader: View {
    var asset: Asset
    
    var body: some View {
        HStack {
            AsyncImage(url: URL(string: asset.image)) {
                phase in
                if let image = phase.image {
                    image
                        .resizable()
                        .scaledToFit()
                        .frame(width: 35, height: 35)
                        .padding(.trailing, 5)
                } else if phase.error != nil {
                    ProgressView().onAppear{
                        print(ErrorHandler.imageDoesNotExist.errorDescription!)
                        
                    }
                } else {
                    ProgressView()
                }
            }
            Text(asset.name.capitalized(with: .current)).font(.title).fontWeight(.bold).foregroundColor(Color("OffBlack"))
            Spacer()
            VStack {
                HStack{
                    Spacer()
                    Text(asset.currentPrice.formatted(.currency(code: "USD")))
                        .foregroundColor(Color("OffBlack").opacity(0.8))
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
            }.offset(y: 10)
        }.padding()
    }
}

struct DetailsHeader_Previews: PreviewProvider {
    static var previews: some View {
        DetailsHeader(asset: Asset(id: "test", symbol: "test", name: "test", image: "test", currentPrice: 0.0, priceChange24H: 0.0))
    }
}
