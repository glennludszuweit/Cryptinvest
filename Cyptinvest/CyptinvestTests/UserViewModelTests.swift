//
//  UserViewModelTests.swift
//  CyptinvestTests
//
//  Created by Glenn Ludszuweit on 29/05/2023.
//

import XCTest
import CoreData

@testable import Cyptinvest

class UserViewModelTests: XCTestCase {
    var viewModel: UserViewModel!
    var context: NSManagedObjectContext!
    var fakeNetworkManager: FakeNetworkManager!
    var fakeCoreDataManager: FakeCoreDataManager!
    
    @MainActor override func setUpWithError() throws {
        try super.setUpWithError()
        
        let managedObjectModel = NSManagedObjectModel.mergedModel(from: [Bundle.main])!
        let persistentStoreCoordinator = NSPersistentStoreCoordinator(managedObjectModel: managedObjectModel)
        try persistentStoreCoordinator.addPersistentStore(ofType: NSInMemoryStoreType, configurationName: nil, at: nil, options: nil)
        context = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
        context.persistentStoreCoordinator = persistentStoreCoordinator
        
        fakeNetworkManager = FakeNetworkManager()
        fakeCoreDataManager = FakeCoreDataManager(context: context)
        viewModel = UserViewModel(manager: fakeCoreDataManager, context: context)
    }
    
    override func tearDownWithError() throws {
        viewModel = nil
        context = nil
        try super.tearDownWithError()
    }
    
    @MainActor func testUpdatePortfolio() async {
        let asset = Asset(id: "bitcoin", symbol: "BTC", name: "Bitcoin", image: "", currentPrice: 40000.0, marketCap: nil, fullyDilutedValuation: nil, totalVolume: nil, priceChangePercentage24H: nil, circulatingSupply: nil, totalSupply: nil, maxSupply: nil, sparklineIn7D: nil, currentHoldings: 1.0)
        let user = UserModel(usd: 10000.0, worth: 10000.0)
        
        do {
            try fakeCoreDataManager.buyAsset(asset: asset, amount: 1.0, priceBought: 30000.0)
            try fakeCoreDataManager.saveUserData(user: user)
        } catch let error {
            print(error.localizedDescription)
        }
        
        viewModel.manager = fakeCoreDataManager
        await viewModel.updatePortfolio(asset: asset, amount: 1.0, context: context, operation: "Sell")
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            XCTAssertEqual(self.fakeCoreDataManager.fakeUserAssets.count, 1, "Unexpected number of user assets")
            XCTAssertEqual(self.fakeCoreDataManager.fakeUserAssets[0].amount, 0.0, "Unexpected asset amount")
            XCTAssertEqual(self.fakeCoreDataManager.fakeUserData[0].usd, 70000.0, "Unexpected user USD balance")
        }
    }
    
    @MainActor func testPopulateUserAssetsList() {
        let assetViewModel = AssetDetailsViewModel(manager: FakeNetworkManager())
        let asset1 = Asset(id: "bitcoin", symbol: "BTC", name: "Bitcoin", image: "", currentPrice: 40000.0, marketCap: nil, fullyDilutedValuation: nil, totalVolume: nil, priceChangePercentage24H: nil, circulatingSupply: nil, totalSupply: nil, maxSupply: nil, sparklineIn7D: nil, currentHoldings: 1.0)
        let asset2 = Asset(id: "ethereum", symbol: "ETH", name: "Ethereum", image: "", currentPrice: 3000.0, marketCap: nil, fullyDilutedValuation: nil, totalVolume: nil, priceChangePercentage24H: nil, circulatingSupply: nil, totalSupply: nil, maxSupply: nil, sparklineIn7D: nil, currentHoldings: 2.0)
        
        let jsonFileURL = Bundle(for: type(of: self)).url(forResource: "coingecko", withExtension: "json")!
        let jsonData = try! Data(contentsOf: jsonFileURL)
        
        fakeNetworkManager.fakeResponse = jsonData
        
        do {
            try fakeCoreDataManager.buyAsset(asset: asset1, amount: 0.5, priceBought: 30000.0)
            try fakeCoreDataManager.buyAsset(asset: asset2, amount: 2.0, priceBought: 2000.0)
        } catch let error {
            print(error.localizedDescription)
        }
        
        viewModel.manager = fakeCoreDataManager
        assetViewModel.manager = fakeNetworkManager
        
        viewModel.populateUserAssetsList(assetViewModel: assetViewModel)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            XCTAssertEqual(self.viewModel.assets.count, 2, "Unexpected number of assets")
            XCTAssertEqual(self.viewModel.assets[0].id, "bitcoin", "Unexpected asset ID")
            XCTAssertEqual(self.viewModel.assets[0].currentHoldings, 0.5, "Unexpected asset holdings")
            XCTAssertEqual(self.viewModel.assets[1].id, "ethereum", "Unexpected asset ID")
            XCTAssertEqual(self.viewModel.assets[1].currentHoldings, 2.0, "Unexpected asset holdings")
        }
    }
    
    @MainActor func testCalculateUsersWorth() {
        let user = UserModel(usd: 10000.0, worth: 10000.0)
        let asset1 = Asset(id: "bitcoin", symbol: "BTC", name: "Bitcoin", image: "", currentPrice: 40000.0, marketCap: nil, fullyDilutedValuation: nil, totalVolume: nil, priceChangePercentage24H: nil, circulatingSupply: nil, totalSupply: nil, maxSupply: nil, sparklineIn7D: nil, currentHoldings: 1.0)
        let asset2 = Asset(id: "ethereum", symbol: "ETH", name: "Ethereum", image: "", currentPrice: 3000.0, marketCap: nil, fullyDilutedValuation: nil, totalVolume: nil, priceChangePercentage24H: nil, circulatingSupply: nil, totalSupply: nil, maxSupply: nil, sparklineIn7D: nil, currentHoldings: 2.0)
        
        do {
            try fakeCoreDataManager.buyAsset(asset: asset1, amount: 0.5, priceBought: 30000.0)
            try fakeCoreDataManager.buyAsset(asset: asset2, amount: 2.0, priceBought: 2000.0)
            try fakeCoreDataManager.saveUserData(user: user)
        } catch let error {
            print(error.localizedDescription)
        }
        
        let viewModel = UserViewModel(manager: fakeCoreDataManager, context: fakeCoreDataManager.context)
        viewModel.assetPrices.append(asset1.currentPrice)
        viewModel.assetPrices.append(asset1.currentPrice)
        viewModel.calculateUsersWorth()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            XCTAssertEqual(viewModel.assetPrices.count, 2, "Unexpected number of asset prices")
            XCTAssertEqual(viewModel.assetPrices[0], 40000.0, "Unexpected asset price")
            XCTAssertEqual(viewModel.assetPrices[1], 6000.0, "Unexpected asset price")
            XCTAssertEqual(viewModel.assetsTotalWorth, 51500.0, "Unexpected total worth")
        }
    }
    
    func testSaveUserData() async {
        let viewModel = await UserViewModel(manager: fakeCoreDataManager, context: context)
        let user = UserModel(usd: 10000.0, worth: 10000.0)
        
        await viewModel.saveUserData(user: user)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            XCTAssertEqual(self.fakeCoreDataManager.fakeUserData.count, 1, "User data was not saved")
            XCTAssertEqual(self.fakeCoreDataManager.fakeUserData.first?.usd, user.usd, "Incorrect USD value saved")
            XCTAssertEqual(self.fakeCoreDataManager.fakeUserData.first?.worth, user.worth, "Incorrect worth value saved")
        }
    }
}
