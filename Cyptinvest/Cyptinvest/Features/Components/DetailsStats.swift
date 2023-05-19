//
//  DetailsStats.swift
//  Cyptinvest
//
//  Created by Glenn Ludszuweit on 19/05/2023.
//

import SwiftUI

struct DetailsStats: View {
    var title: String
    var data: String
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(title).foregroundColor(Color("OffBlack").opacity(0.75)).padding(.bottom, 3)
            Text(data).foregroundColor(Color("OffBlack")).fontWeight(.semibold)
        }.padding()
            .font(.custom("", size: 14))
    }
}

struct DetailsStats_Previews: PreviewProvider {
    static var previews: some View {
        DetailsStats(title: "", data: "")
    }
}
