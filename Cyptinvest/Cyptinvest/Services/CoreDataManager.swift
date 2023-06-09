//
//  CoreDataManager.swift
//  Cyptinvest
//
//  Created by Glenn Ludszuweit on 24/05/2023.
//

import Foundation
import CoreData
import SwiftUI

class CoreDataManager: CoreDataProtocol {
    var context: NSManagedObjectContext
    
    init(context: NSManagedObjectContext) {
        self.context = context
    }
    
    func saveUserData(user: UserModel) throws {
        let userEntity = UserEntity(context: context)
        userEntity.usd = user.usd
        userEntity.worth = user.worth
        save()
    }
    
    func updateUserData(userEntity: UserEntity, usd: Double, worth: Double) throws {
        userEntity.usd = usd
        userEntity.worth = worth
        save()
    }
    
    func buyAsset(asset: Asset, amount: Double, priceBought: Double) throws {
        let assetEntity = AssetEntity(context: context)
        assetEntity.id = asset.id
        assetEntity.amount = amount
        assetEntity.priceBought = priceBought
        save()
    }
    
    func updateAsset(assetEntity: AssetEntity, amount: Double) throws {
        assetEntity.amount = amount
        save()
    }
    
    func deleteAsset(assetEntity: AssetEntity) throws {
        context.delete(assetEntity)
    }
    
    func save() {
        do {
            try context.save()
        } catch let error {
            print(error)
        }
    }
}
