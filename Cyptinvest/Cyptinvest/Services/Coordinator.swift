//
//  Coordinator.swift
//  Cyptinvest
//
//  Created by Glenn Ludszuweit on 18/05/2023.
//

import Foundation
import SwiftUI

class Coordinator: ObservableObject {
    @Published var navigationPath = NavigationPath()
    var asset = Asset(id: "test", symbol: "test", name: "test", image: "test", currentPrice: 0.0, priceChange24H: 0.0)
    
    func assetsList() {
        navigationPath.append(CurrentPage.assetsList)
    }
    
    func assetDetails(asset: Asset) {
        self.asset = asset
        navigationPath.append(CurrentPage.assetDetails)
    }
}

enum CurrentPage {
    case assetsList
    case assetDetails
}
