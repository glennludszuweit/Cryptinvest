//
//  FakeCoreDataManager.swift
//  CyptinvestTests
//
//  Created by Glenn Ludszuweit on 29/05/2023.
//

import Foundation
import CoreData

@testable import Cyptinvest

class FakeCoreDataManager: CoreDataProtocol {
    var context: NSManagedObjectContext
    var fakeUserAssets: [AssetEntity] = []
    var fakeUserData: [UserEntity] = []
    
    init(context: NSManagedObjectContext) {
        self.context = context
    }
    
    func saveUserData(user: UserModel) throws {
        let userEntity = UserEntity(context: context)
        userEntity.usd = user.usd
        userEntity.worth = user.worth
        fakeUserData.append(userEntity)
    }
    
    func updateUserData(userEntity: UserEntity, usd: Double, worth: Double) throws {
        userEntity.usd = usd
        userEntity.worth = worth
    }
    
    func buyAsset(asset: Asset, amount: Double, priceBought: Double) throws {
        let assetEntity = AssetEntity(context: context)
        assetEntity.id = asset.id
        assetEntity.amount = amount
        assetEntity.priceBought = priceBought
        fakeUserAssets.append(assetEntity)
    }
    
    func updateAsset(assetEntity: AssetEntity, amount: Double) throws {
        assetEntity.amount = amount
    }
    
    func deleteAsset(assetEntity: AssetEntity) throws {
        if let index = fakeUserAssets.firstIndex(of: assetEntity) {
            fakeUserAssets.remove(at: index)
        }
    }
    
    func save() {}
}
