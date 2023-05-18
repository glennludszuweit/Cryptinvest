//
//  CustomTabBar.swift
//  Cyptinvest
//
//  Created by Glenn Ludszuweit on 16/05/2023.
//

import SwiftUI

struct CustomTabBar: View {
    @State var currentTab: Tab = .Assets
    @Namespace var animation
    
    var body: some View {
        VStack {
            ZStack(alignment: .bottom) {
                TabView(selection: $currentTab) {
                    Group {
                        AssetsListView(assetsViewModel: AssetsViewModel(manager: NetworkManager()))
                            .tag(Tab.Assets)
                        Text("Portfolio")
                            .tag(Tab.Portfolio)
                        Text("Settings")
                            .tag(Tab.Settings)
                    }.frame(maxWidth: .infinity, maxHeight: .infinity)
                }
                
                HStack(spacing: 0) {
                    ForEach(Tab.allCases, id: \.rawValue) { tab in
                        TabBarButton(currentTab: $currentTab, tab: tab, animation: animation) {  tab in
                            withAnimation(.spring()) {
                                currentTab = tab
                            }
                        }
                    }
                }
                .padding(.horizontal)
                .padding(.bottom, 20)
                .padding(.top, 15)
                .background(.white)
                .overlay(RoundedRectangle(cornerRadius: 10)
                    .stroke(Color("Purple").opacity(0.5), lineWidth: 2))
                .shadow(color: Color.black.opacity(0.2), radius: 10)
                .offset(y: 35)
            }
        }
    }
}

enum Tab: String, CaseIterable {
    case Assets = "magnifyingglass"
    case Portfolio = "dollarsign"
    case Settings = "gearshape"
}
