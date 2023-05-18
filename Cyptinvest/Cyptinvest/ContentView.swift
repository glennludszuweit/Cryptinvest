//
//  ContentView.swift
//  Cyptinvest
//
//  Created by Glenn Ludszuweit on 16/05/2023.
//

import SwiftUI
import CoreData

struct ContentView: View {
    init() {
        UITabBar.appearance().isHidden = true
    }
    
    var body: some View {
        VStack {
            CustomTabBar()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}

