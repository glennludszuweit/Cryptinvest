//
//  CoreDataProtocol.swift
//  Cyptinvest
//
//  Created by Glenn Ludszuweit on 24/05/2023.
//

import Foundation
import CoreData
import SwiftUI

protocol CoreDataProtocol {
    func saveUserData(user: UserModel) throws
    func updateUserData(userEntity: UserEntity, usd: Double, worth: Double) throws
    func buyAsset(asset: Asset, amount: Double) throws
    func updateAsset(assetEntity: AssetEntity, amount: Double) throws
    func deleteAsset(assetEntity: AssetEntity) throws
    func save()
}
