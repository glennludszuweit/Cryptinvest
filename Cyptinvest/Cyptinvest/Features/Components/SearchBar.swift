//
//  SearchBar.swift
//  Cyptinvest
//
//  Created by Glenn Ludszuweit on 18/05/2023.
//

import SwiftUI

struct SearchBar: View {
    @State var assetsViewModel: AssetsViewModel
    @State var searchTerm: String = ""
    
    var body: some View {
        HStack {
            TextField("Search coins", text: $searchTerm)
                .modifier(ClearButton(text: $searchTerm))
                .padding(10)
                .overlay(RoundedRectangle(cornerRadius: 10)
                    .stroke(Color("Purple").opacity(0.5), lineWidth: 2))
                .onChange(of: searchTerm) { term in
                    assetsViewModel.searchAssets(searchTerm: term)
                }
        }.padding()
    }
}

struct SearchBar_Previews: PreviewProvider {
    static var previews: some View {
        SearchBar(assetsViewModel: AssetsViewModel(manager: NetworkManager()))
    }
}
