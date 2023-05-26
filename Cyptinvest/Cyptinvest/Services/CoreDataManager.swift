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
    
    func buyAsset(asset: Asset, amount: Double) throws {
        let assetEntity = AssetEntity(context: context)
        assetEntity.id = asset.id
        assetEntity.amount = amount
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
