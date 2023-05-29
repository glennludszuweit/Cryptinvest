//
//  AssetDetailsViewModelTests.swift
//  CyptinvestTests
//
//  Created by Glenn Ludszuweit on 29/05/2023.
//

import XCTest

@testable import Cyptinvest

final class AssetDetailsViewModelTests: XCTestCase {
    var viewModel: AssetDetailsViewModel!
    var fakeNetworkManager: FakeNetworkManager!
    
    @MainActor override func setUp() {
        super.setUp()
        fakeNetworkManager = FakeNetworkManager()
        viewModel = AssetDetailsViewModel(manager: fakeNetworkManager)
    }
    
    override func tearDown() {
        viewModel = nil
        fakeNetworkManager = nil
        super.tearDown()
    }
    
    @MainActor func testGetCoinDetails_SuccessfulResponse() async {
        await viewModel.getCoinDetails("https://example.com/asset_detail")
        XCTAssertNil(viewModel.assetDetail, "Asset Detail Expected to be nil.")
    }
}
