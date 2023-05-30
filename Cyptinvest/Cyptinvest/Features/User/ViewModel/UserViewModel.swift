//
//  UserViewModel.swift
//  Cyptinvest
//
//  Created by Glenn Ludszuweit on 17/05/2023.
//

import Foundation
import SwiftUI
import CoreData

@MainActor
class UserViewModel: ObservableObject {
    @Published var customError: ErrorHandler?
    @Published var assets: [Asset] = []
    @Published var userData: [UserEntity] = []
    @Published var userAssets: [AssetEntity] = []
    @Published var assetPrices: [Double] = []
    @Published var assetsTotalWorth: Double = 10000
    
    var manager: CoreDataProtocol
    
    init(manager: CoreDataProtocol, context: NSManagedObjectContext) {
        self.manager = manager
        self.getUserAssets(context: context)
        self.getUserData(context: context)
    }
    
    func updatePortfolio(asset: Asset, amount: Double, context: NSManagedObjectContext, operation: String) async{
        if let entity = userAssets.first(where: { $0.id == asset.id}) {
            if amount > 0 {
                if operation == "Sell" && entity.amount >= amount {
                    await updateAsset(assetEntity: entity, amount: entity.amount - amount, context: context)
                    await updateUserData(userentity: userData.first!, usd: (userData.first?.usd ?? 0) + (asset.currentPrice * amount), worth: 10000.00, context: context)
                } else {
                    await updateAsset(assetEntity: entity, amount: entity.amount + amount, context: context)
                    await updateUserData(userentity: userData.first!, usd: (userData.first?.usd ?? 0) - (asset.currentPrice * amount), worth: 10000.00, context: context)
                }
            } else {
                await  deleteAsset(assetEntity: entity, context: context)
            }
        } else {
            await buyAsset(asset: asset, amount: amount, priceBought: asset.currentPrice, context: context)
            await updateUserData(userentity: userData.first!, usd: (userData.first?.usd ?? 0) - (asset.currentPrice * amount), worth: 10000.00, context: context)
        }
    }
    
    func populateUserAssetsList(assetViewModel: AssetDetailsViewModel) {
        userAssets.forEach { item in
            Task {
                await assetViewModel.getCoinDetails("\(API.coingeckoGetCoinApi)\(item.id?.lowercased() ?? "bitcoin")\(API.coingeckoGetCoinApiQuery)")
                if let assetDetail = assetViewModel.assetDetail {
                    assets.append(Asset(id: assetDetail.id ?? "", symbol: assetDetail.symbol ?? "", name: assetDetail.name ?? "", image: assetDetail.image?.thumb ?? "", currentPrice: assetDetail.marketData?.currentPrice?["usd"] ?? 0, marketCap: assetDetail.marketData?.marketCap?["usd"], fullyDilutedValuation: assetDetail.marketData?.fullyDilutedValuation?["usd"], totalVolume: assetDetail.marketData?.totalVolume?["usd"], priceChangePercentage24H: assetDetail.marketData?.priceChangePercentage24h, circulatingSupply: assetDetail.marketData?.circulatingSupply, totalSupply: assetDetail.marketData?.totalSupply, maxSupply: assetDetail.marketData?.maxSupply, sparklineIn7D: assetDetail.marketData?.sparkLine7D, currentHoldings: item.amount))
                }
            }
        }
    }
    
    func calculateUsersWorth() {
        DispatchQueue.main.asyncAfter (deadline: .now() + 1) {
            self.assets.forEach { item in
                self.assetPrices.append(item.currentPrice * (item.currentHoldings ?? 0))
            }
            self.assetsTotalWorth = self.assetPrices.reduce(0.0) { $0 + $1 } + (self.userData.first?.usd ?? 0)
        }
    }
    
    func saveUserData(user: UserModel = UserModel(usd: 10000.00, worth: 10000.00)) async {
        do {
            try manager.saveUserData(user: user )
        } catch let error {
            if error as? ErrorHandler == .parsingError {
                customError = ErrorHandler.parsingError
            } else {
                customError = ErrorHandler.apiEndpointError
            }
        }
    }
    
    private func getUserData(context: NSManagedObjectContext) {
        let request = NSFetchRequest<UserEntity>(entityName: "UserEntity")
        do {
            userData = try context.fetch(request)
        } catch let error {
            if error as? ErrorHandler == .parsingError {
                customError = ErrorHandler.parsingError
            } else {
                customError = ErrorHandler.apiEndpointError
            }
        }
    }
    
    private func updateUserData(userentity: UserEntity, usd: Double, worth: Double, context: NSManagedObjectContext) async {
        do {
            try manager.updateUserData(userEntity: userentity, usd: usd, worth: worth)
            applyChanges(context: context)
        } catch let error {
            if error as? ErrorHandler == .parsingError {
                customError = ErrorHandler.parsingError
            } else {
                customError = ErrorHandler.apiEndpointError
            }
        }
    }
    
    private func getUserAssets(context: NSManagedObjectContext) {
        let request = NSFetchRequest<AssetEntity>(entityName: "AssetEntity")
        do {
            userAssets = try context.fetch(request)
        } catch let error {
            if error as? ErrorHandler == .parsingError {
                customError = ErrorHandler.parsingError
            } else {
                customError = ErrorHandler.apiEndpointError
            }
        }
    }
    
    private func buyAsset(asset: Asset, amount: Double, priceBought: Double, context: NSManagedObjectContext) async {
        do {
            try manager.buyAsset(asset: asset, amount: amount, priceBought: priceBought)
            applyChanges(context: context)
        } catch let error {
            if error as? ErrorHandler == .parsingError {
                customError = ErrorHandler.parsingError
            } else {
                customError = ErrorHandler.apiEndpointError
            }
        }
    }
    
    private func updateAsset(assetEntity: AssetEntity, amount: Double, context: NSManagedObjectContext) async {
        do {
            try manager.updateAsset(assetEntity: assetEntity, amount: amount)
            applyChanges(context: context)
        } catch let error {
            if error as? ErrorHandler == .parsingError {
                customError = ErrorHandler.parsingError
            } else {
                customError = ErrorHandler.apiEndpointError
            }
        }
    }
    
    private func deleteAsset(assetEntity: AssetEntity, context: NSManagedObjectContext) async {
        do {
            try manager.deleteAsset(assetEntity: assetEntity)
            applyChanges(context: context)
        } catch let error {
            if error as? ErrorHandler == .parsingError {
                customError = ErrorHandler.parsingError
            } else {
                customError = ErrorHandler.apiEndpointError
            }
        }
    }
    
    private func applyChanges(context: NSManagedObjectContext) {
        manager.save()
        getUserAssets(context: context)
        getUserData(context: context)
    }
}
