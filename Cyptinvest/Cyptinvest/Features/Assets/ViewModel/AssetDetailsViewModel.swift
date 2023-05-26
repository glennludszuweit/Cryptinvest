//
//  AssetDetailsViewModel.swift
//  Cyptinvest
//
//  Created by Glenn Ludszuweit on 19/05/2023.
//

import Foundation

@MainActor
class AssetDetailsViewModel: ObservableObject {
    @Published var assetDetail: AssetDetail?
    @Published var customError: ErrorHandler?
    
    var manager: NetworkProtocol
    init(manager: NetworkProtocol) {
        self.manager = manager
    }
    
    func getCoinDetails(_ urlString: String) async {
        guard let url = URL(string: urlString) else {
            customError = ErrorHandler.invalidUrlError
            return
        }
        do {
            let result = try await self.manager.get(apiURL: url)
            let data = try JSONDecoder().decode(AssetDetail.self, from: result)
            self.assetDetail = data
        } catch let error {
            if error as? ErrorHandler == .parsingError {
                customError = ErrorHandler.parsingError
            } else {
                customError = ErrorHandler.apiEndpointError
            }
        }
    }
}
