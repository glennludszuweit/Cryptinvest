//
//  TabBarButton.swift
//  Cyptinvest
//
//  Created by Glenn Ludszuweit on 18/05/2023.
//

import SwiftUI

struct TabBarButton: View {
    @Binding var currentTab: Tab
    var tab: Tab
    var animation: Namespace.ID
    var onTap: (Tab) -> ()
    
    var body: some View {
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

//struct TabBarButton_Previews: PreviewProvider {
//    static var previews: some View {
//        TabBarButton(currentTab: .constant(Tab.Assets), tab: Tab.Assets, animation: Namespace.ID, onTap: (Tab) -> ())
//    }
//}
