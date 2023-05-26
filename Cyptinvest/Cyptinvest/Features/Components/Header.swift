//
//  Header.swift
//  Cyptinvest
//
//  Created by Glenn Ludszuweit on 19/05/2023.
//

import SwiftUI
import CoreData

struct Header: View {
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
            Text("\((result.first?.usd ?? 0).formatted(.currency(code: "USD")))")
                .fontWeight(.semibold)
                .foregroundColor(Color("Black"))
                .padding()
        }.padding(.bottom,-10)
    }
}

struct Header_Previews: PreviewProvider {
    static var previews: some View {
        Header()
    }
}
