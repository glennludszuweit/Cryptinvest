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
    
    func assetsList() {
        navigationPath.append(CurrentPage.assetsList)
    }
    
    func assetDetails() {
        navigationPath.append(CurrentPage.assetDetails)
    }
}

enum CurrentPage {
    case assetsList
    case assetDetails
}
