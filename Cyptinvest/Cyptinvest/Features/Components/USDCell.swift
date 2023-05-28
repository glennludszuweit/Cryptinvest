//
//  USDCell.swift
//  Cyptinvest
//
//  Created by Glenn Ludszuweit on 28/05/2023.
//

import SwiftUI

struct USDCell: View {
    var amount: Double = 0
    
    var body: some View {
        VStack {
            HStack {
                Group {
                    Image("usd")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 30, height: 30)
                        .padding(.trailing, 2)
                    Text("USD")
                        .foregroundColor(Color("Black").opacity(0.8))
                        .font(.subheadline).fontWeight(.semibold)
                }
                Spacer()
                VStack {
                    HStack{
                        Spacer()
                        Text(amount.formatted(.currency(code: "USD")))
                            .foregroundColor(Color("Black").opacity(0.8))
                            .font(.subheadline)
                            .fontWeight(.semibold)
                    }
                }
                
            }.padding(5)
                .padding(.bottom, -10)
                .frame(maxWidth: .infinity)
        }.padding(20)
        .listRowSeparator(.hidden)
    }
}

struct USDCell_Previews: PreviewProvider {
    static var previews: some View {
        USDCell()
    }
}
