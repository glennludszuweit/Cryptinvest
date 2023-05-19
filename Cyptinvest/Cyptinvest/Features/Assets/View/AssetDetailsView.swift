//
//  AssetDetailsView.swift
//  Cyptinvest
//
//  Created by Glenn Ludszuweit on 17/05/2023.
//

import SwiftUI

struct AssetDetailsView: View {
    @StateObject var assetViewModel: AssetViewModel
    var columns: [GridItem] = [
        GridItem(.flexible()),
        GridItem(.flexible()),
    ]
    var asset: Asset
    var body: some View {
        ScrollView {
            VStack {
                header(asset: asset)
                actionButtons()
            }
            
            VStack(spacing: 20) {
                Group {
                    HStack {
                        Text("Overview").font(.title).fontWeight(.bold)
                        Spacer()
                    }
                    Divider()
                    LazyVGrid(columns: columns, alignment: .leading, spacing: nil, pinnedViews: []) {
                        statsView(title: "Market Cap:", data: (asset.marketCap?.formatted(.currency(code: "USD")))!)
                        statsView(title: "24 Hour Trading Vol:", data: (asset.totalVolume?.formatted(.currency(code: "USD")))!)
                        statsView(title: "Fully Diluted Valuation:", data: (asset.fullyDilutedValuation?.formatted(.currency(code: "USD")))! ?? "")
                        statsView(title: "Circulating Supply:", data: (asset.circulatingSupply?.formatted(.currency(code: "USD")))!)
                        statsView(title: "Total Supply:", data: (asset.totalSupply?.formatted(.currency(code: "USD")))!)
                        statsView(title: "Max Supply:", data: (asset.maxSupply?.formatted(.currency(code: "USD"))) ?? "")
                    }
                }
                
                Group {
                    HStack {
                        Text("Additional Information").font(.title).fontWeight(.bold)
                        Spacer()
                    }
                    Divider()
                    LazyVGrid(columns: [GridItem(.flexible())], alignment: .center, spacing: nil, pinnedViews: []) {
                        Text(assetViewModel.assetDetail?.description?.en ?? "").foregroundColor(Color("OffBlack").opacity(0.75))
                    }
                }
                
            }.padding()
        }.task {
            await assetViewModel.getCoinDetails("\(API.coingeckoGetCoinApi)\(asset.name.lowercased())\(API.coingeckoGetCoinApiQuery)")
        }
    }
    
    @ViewBuilder
    func statsView(title: String, data: String) -> some View {
        VStack(alignment: .leading) {
            Text(title).foregroundColor(Color("OffBlack").opacity(0.75)).padding(.bottom, 3)
            Text(data).foregroundColor(Color("OffBlack")).fontWeight(.semibold)
        }.padding()
            .font(.custom("", size: 14))
    }
    
    @ViewBuilder
    func actionButtons() -> some View {
        HStack{
            Group {
                Button {
                    print("Sell")
                } label: {
                    Text("Sell").frame(maxWidth: .infinity)
                }.tint(.green)
                Button {
                    print("Buy")
                } label: {
                    Text("Buy").frame(maxWidth: .infinity)
                }.tint(.red)
            }.buttonStyle(.borderedProminent)
                .padding(20)
        }
    }
    
    @ViewBuilder
    func header(asset: Asset) -> some View {
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
        }.padding(20)
    }
}

struct AssetDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        AssetDetailsView(assetViewModel: AssetViewModel(manager: NetworkManager()), asset: Asset(id: "test", symbol: "test", name: "test", image: "test", currentPrice: 0.0))
    }
}
