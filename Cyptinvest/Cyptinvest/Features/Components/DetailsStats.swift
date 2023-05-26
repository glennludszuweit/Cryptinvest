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
            Group {
                Text(title).opacity(0.75).padding(.bottom, 3)
                Text(data).fontWeight(.semibold)
            }.foregroundColor(Color("Black"))
        }.padding()
            .font(.custom("", size: 14))
    }
}

struct DetailsStats_Previews: PreviewProvider {
    static var previews: some View {
        DetailsStats(title: "", data: "")
    }
}
