//
//  Header.swift
//  Cyptinvest
//
//  Created by Glenn Ludszuweit on 19/05/2023.
//

import SwiftUI
import CoreData

struct Header: View {
    @EnvironmentObject var coordinator: Coordinator
    
    var fetchRequest: NSFetchRequest<UserEntity> = UserEntity.fetchRequest()
    @FetchRequest(entity: UserEntity.entity(), sortDescriptors: [])
    var result: FetchedResults<UserEntity>
    
    var body: some View {
        HStack{
            Image("logo", label: Text("Cryptinvest"))
                .resizable()
                .scaledToFit()
                .frame(height: 50)
                .padding(5)
            Spacer()
            Image(systemName: "person.fill")
                .resizable()
                .frame(width: 25, height: 25)
                .foregroundColor(Color("Purple"))
                .padding()
                .onTapGesture {
                    coordinator.userPortfolio()
                }
        }.padding(.bottom,-10)
    }
}

struct Header_Previews: PreviewProvider {
    static var previews: some View {
        Header()
    }
}
