//
//  AssetsViewModel.swift
//  Cyptinvest
//
//  Created by Glenn Ludszuweit on 17/05/2023.
//

import Foundation

@MainActor
class AssetsViewModel: ObservableObject {
    @Published var assets = [Asset]()
    @Published var customError: ErrorHandler?
    
    var assetsList: [Asset] = []
    var manager: NetworkProtocol
    init(manager: NetworkProtocol) {
        self.manager = manager
    }
    
    func getAll(_ urlString: String = API.coingeckoApi) async {
        guard let url = URL(string: urlString) else {
            customError = ErrorHandler.invalidUrlError
            return
        }
        do {
            let result = try await self.manager.getAll(apiURL: url)
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
            self.assets =  self.assetsList.filter { $0.symbol.lowercased().contains(searchTerm.lowercased()) || $0.name.lowercased().contains(searchTerm.lowercased()) }
        }
    }
}
