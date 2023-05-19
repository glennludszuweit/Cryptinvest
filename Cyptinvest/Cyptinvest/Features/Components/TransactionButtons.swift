//
//  TransactionButtons.swift
//  Cyptinvest
//
//  Created by Glenn Ludszuweit on 19/05/2023.
//

import SwiftUI

struct TransactionButtons: View {
    var body: some View {
        HStack{
            Group {
                Button {
                    print("Sell")
                } label: {
                    Text("Sell").frame(maxWidth: .infinity)
                }.tint(.green)
                Button {
                    print("Buy")
                } label: {
                    Text("Buy").frame(maxWidth: .infinity)
                }.tint(.red)
            }.buttonStyle(.borderedProminent)
                .padding(20)
        }
    }
}

struct TransactionButtons_Previews: PreviewProvider {
    static var previews: some View {
        TransactionButtons()
    }
}
