//
//  AssetsViewModel.swift
//  Cyptinvest
//
//  Created by Glenn Ludszuweit on 17/05/2023.
//

import Foundation

@MainActor
class AssetsViewModel: ObservableObject {
    @Published var combinedAssets: [Asset] = []
    @Published var assets = [Asset]()
    @Published var customError: ErrorHandler?
    
    var assetsList: [Asset] = []
    var manager: NetworkProtocol
    init(manager: NetworkProtocol) {
        self.manager = manager
    }
    
    func getMarketAssets(_ urlString: String = API.coingeckoApi) async {
        guard let url = URL(string: urlString) else {
            customError = ErrorHandler.invalidUrlError
            return
        }
        do {
            let result = try await self.manager.get(apiURL: url)
            let data = try JSONDecoder().decode([Asset].self, from: result)
            self.assetsList = data
            self.searchAssets(searchTerm: "")
        } catch let error {
            if error as? ErrorHandler == .parsingError {
                customError = ErrorHandler.parsingError
            } else {
                customError = ErrorHandler.apiEndpointError
            }
        }
    }
    
    func searchAssets(searchTerm: String) {
        if searchTerm.isEmpty {
            self.assets = self.assetsList
        } else {
            self.combinedAssets =  self.assetsList.filter { $0.symbol.lowercased().contains(searchTerm.lowercased()) || $0.name.lowercased().contains(searchTerm.lowercased()) }
        }
    }
    
    func addAndReduceUserAssetsWithApiResult(userViewModel: UserViewModel, assetViewModel: AssetDetailsViewModel) {
        if userViewModel.assets.count == 0 {
            userViewModel.userAssets.forEach { item in
                Task {
                    await assetViewModel.getCoinDetails("\(API.coingeckoGetCoinApi)\(item.id?.lowercased() ?? "bitcoin")\(API.coingeckoGetCoinApiQuery)")
                    if let assetDetail = assetViewModel.assetDetail {
                        userViewModel.assets.append(Asset(id: assetDetail.id ?? "", symbol: assetDetail.symbol ?? "", name: assetDetail.name ?? "", image: assetDetail.image?.thumb ?? "", currentPrice: assetDetail.marketData?.currentPrice?["usd"] ?? 0, marketCap: assetDetail.marketData?.marketCap?["usd"], fullyDilutedValuation: assetDetail.marketData?.fullyDilutedValuation?["usd"], totalVolume: assetDetail.marketData?.totalVolume?["usd"], priceChangePercentage24H: assetDetail.marketData?.priceChangePercentage24h, circulatingSupply: assetDetail.marketData?.circulatingSupply, totalSupply: assetDetail.marketData?.totalSupply, maxSupply: assetDetail.marketData?.maxSupply, sparklineIn7D: assetDetail.marketData?.sparkLine7D, currentHoldings: item.amount))
                    }
                }
            }
        }
        let items = userViewModel.assets + self.assets
        self.combinedAssets = items.reduce(into: [Asset]()) { result, element in
            if let index = result.firstIndex(where: { $0.id == element.id }) {
                result[index].id += element.id
            } else {
                result.append(element)
            }
        }
    }
}
