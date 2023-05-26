//
//  RegisterView.swift
//  Cyptinvest
//
//  Created by Glenn Ludszuweit on 21/05/2023.
//

import SwiftUI
import CoreData
import UIKit

struct LaunchView: UIViewControllerRepresentable {
    @StateObject var userViewModel: UserViewModel
    @EnvironmentObject var coordinator: Coordinator
    @State var navigate = true
    
    @Environment(\.managedObjectContext) private var viewContext
    
    var fetchRequest: NSFetchRequest<UserEntity> = UserEntity.fetchRequest()
    @FetchRequest(entity: UserEntity.entity(), sortDescriptors: [])
    var result: FetchedResults<UserEntity>
    
    func makeUIViewController(context: Context) -> UIViewController {
        
        if result.isEmpty {
            Task {
                await userViewModel.saveUserData()
                guard let url = FileManager.default.urls(for: .applicationSupportDirectory, in: .userDomainMask).first else {return}
                let sqlitePath = url.appendingPathComponent("Cryptinvest.sqlite")
                print(sqlitePath)
            }
        }
        Task {
            guard let url = FileManager.default.urls(for: .applicationSupportDirectory, in: .userDomainMask).first else {return}
            let sqlitePath = url.appendingPathComponent("Cryptinvest.sqlite")
            print(sqlitePath)
        }
        let storyboard = UIStoryboard(name: "Launch", bundle: Bundle.main)
        let launchViewController = storyboard.instantiateViewController(withIdentifier: "LaunchViewController")
        return launchViewController
    }
    
    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {
        if navigate {
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                coordinator.assetsList()
                navigate = false
            }
        }
    }
}
