//
//  AssetsListView.swift
//  Cyptinvest
//
//  Created by Glenn Ludszuweit on 17/05/2023.
//

import SwiftUI
import CoreData

struct AssetsListView: View {
    @StateObject var assetsViewModel: AssetsViewModel
    
    var fetchRequest: NSFetchRequest<UserEntity> = UserEntity.fetchRequest()
    @FetchRequest(entity: UserEntity.entity(), sortDescriptors: [])
    var result: FetchedResults<UserEntity>
    
    var body: some View {
        if !result.isEmpty {
            VStack {
                SearchBar(assetsViewModel: assetsViewModel)
                AssetsList(assetsViewModel: assetsViewModel)
            }.navigationBarHidden(true)
        } else {
            ProgressView()
        }
    }
}

struct AssetsListView_Previews: PreviewProvider {
    static var previews: some View {
        AssetsListView(assetsViewModel: AssetsViewModel(manager: NetworkManager()))
    }
}
