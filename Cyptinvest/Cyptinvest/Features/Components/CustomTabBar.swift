//
//  CustomTabBar.swift
//  Cyptinvest
//
//  Created by Glenn Ludszuweit on 18/05/2023.
//

import SwiftUI

struct CustomTabBar: View {
    @State var currentTab: Tab = .Assets
    @Namespace var animation
    
    init() {
        UITabBar.appearance().isHidden = true
    }
    
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
                        TabBarButton(tab: tab, animation: animation) {  tab in
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
    
    @ViewBuilder
    func TabBarButton(tab: Tab, animation: Namespace.ID, onTap: @escaping (Tab) -> ()) -> some View {
        Image(systemName: tab.rawValue)
            .foregroundColor(currentTab == tab ? .white : .gray)
            .frame(width: 45, height: 45)
            .background(
                ZStack {
                    if currentTab == tab {
                        RoundedRectangle(cornerRadius: 5, style: .continuous)
                            .fill(Color("Purple"))
                            .matchedGeometryEffect(id: "Tab", in: animation)
                    }
                }
            )
            .frame(maxWidth: .infinity)
            .containerShape(Rectangle())
            .onTapGesture {
                onTap(tab)
            }
        
    }
}

struct CustomTabBar_Previews: PreviewProvider {
    static var previews: some View {
        CustomTabBar()
    }
}

enum Tab: String, CaseIterable {
    case Assets = "magnifyingglass"
    case Portfolio = "dollarsign"
    case Settings = "gearshape"
}
