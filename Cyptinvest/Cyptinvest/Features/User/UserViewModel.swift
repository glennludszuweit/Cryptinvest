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
    @Published var userData: [UserEntity] = []
    @Published var userAssets: [AssetEntity] = []
    
    var manager: CoreDataProtocol
    
    init(manager: CoreDataProtocol, context: NSManagedObjectContext) {
        self.manager = manager
        self.getUserAssets(context: context)
    }
    
    func getUserData(context: NSManagedObjectContext) {
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
    
    func saveUserData(user: UserModel = UserModel(usd: 10000.00, worth: 10000.00), context: NSManagedObjectContext) async {
        do {
            let coreDataManager = CoreDataManager(context: context)
            try coreDataManager.saveUserData(user: user )
        } catch let error {
            if error as? ErrorHandler == .parsingError {
                customError = ErrorHandler.parsingError
            } else {
                customError = ErrorHandler.apiEndpointError
            }
        }
    }
    
    func getUserAssets(context: NSManagedObjectContext) {
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
    
    func updatePortfolio(asset: Asset, amount: Double, context: NSManagedObjectContext) async{
        if let entity = userAssets.first(where: { $0.id == asset.id}) {
            if amount > 0 {
                await updateAsset(assetEntity: entity, amount: entity.amount + amount, context: context)
            } else {
                await  deleteAsset(assetEntity: entity, context: context)
            }
        } else {
            await buyAsset(asset: asset, amount: amount, context: context)
        }
    }
    
    private func buyAsset(asset: Asset, amount: Double, context: NSManagedObjectContext) async {
        do {
            try manager.buyAsset(asset: asset, amount: amount)
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
    }
}