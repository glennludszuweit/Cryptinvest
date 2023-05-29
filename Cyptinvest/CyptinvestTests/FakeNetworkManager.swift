//
//  FakeNetworkManager.swift
//  CyptinvestTests
//
//  Created by Glenn Ludszuweit on 29/05/2023.
//

import Foundation

@testable import Cyptinvest

class FakeNetworkManager: NetworkProtocol {
    var fakeResponse = Data()
    func get(apiURL: URL) async throws -> Data {
        // Load JSON data from a file
        if let jsonFileURL = Bundle.main.url(forResource: "coingecko", withExtension: "json"),
           let jsonData = try? Data(contentsOf: jsonFileURL) {
            return jsonData
        } else {
            throw ErrorHandler.apiEndpointError
        }
    }
}
