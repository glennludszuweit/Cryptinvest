//
//  Header.swift
//  Cyptinvest
//
//  Created by Glenn Ludszuweit on 19/05/2023.
//

import SwiftUI

struct Header: View {
    var body: some View {
        HStack{
            Image("logo", label: Text("Cryptinvest"))
                .resizable()
                .scaledToFit()
                .frame(height: 50)
                .padding(5)
            Spacer()
            Text("$10,000.00")
                .fontWeight(.semibold)
                .foregroundColor(Color("OffBlack"))
                .padding()
        }.padding(.bottom,-10)
    }
}

struct Header_Previews: PreviewProvider {
    static var previews: some View {
        Header()
    }
}
