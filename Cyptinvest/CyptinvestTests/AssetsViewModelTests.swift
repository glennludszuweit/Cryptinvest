//
//  AssetsViewModelTests.swift
//  CyptinvestTests
//
//  Created by Glenn Ludszuweit on 29/05/2023.
//

import XCTest

@testable import Cyptinvest

final class AssetsViewModelTests: XCTestCase {
    var viewModel: AssetsViewModel!
    var fakeNetworkManager: FakeNetworkManager!
    
    @MainActor override func setUp() {
        super.setUp()
        fakeNetworkManager = FakeNetworkManager()
        viewModel = AssetsViewModel(manager: fakeNetworkManager)
    }
    
    override func tearDown() {
        viewModel = nil
        fakeNetworkManager = nil
        super.tearDown()
    }
    
    @MainActor func testGetMarketAssets_SuccessfulResponse() async {
        await viewModel.getMarketAssets()
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            XCTAssertEqual(self.viewModel.assets.count, 10, "Unexpected assets count.")
            XCTAssertEqual(self.viewModel.assets[0].id, "bitcoin", "Expected asset ID.")
        }
    }
    
    @MainActor func testGetMarketAssets_InvalidURL() async {
        let invalidURL = "https://invalid-url.com/api"
        await viewModel.getMarketAssets(invalidURL)
        XCTAssertEqual(viewModel.assets.count, 0, "Does not expect any Data.")
    }
    
    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 7.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }
}
