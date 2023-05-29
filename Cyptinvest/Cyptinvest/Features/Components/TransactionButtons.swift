//
//  TransactionButtons.swift
//  Cyptinvest
//
//  Created by Glenn Ludszuweit on 19/05/2023.
//

import SwiftUI

struct TransactionButtons: View {
    @State var showTransaction: Bool = false
    @State var transactionType: String = ""
    @Environment(\.managedObjectContext) private var viewContext
    var asset: Asset
    var body: some View {
        HStack{
            Group {
                Button {
                    transactionType = "Sell"
                    showTransaction = true
                } label: {
                    Text("Sell").frame(maxWidth: .infinity)
                }.tint(Color("Red")).disabled(asset.currentHoldings ?? 0 <= 0)
                Button {
                    transactionType = "Buy"
                    showTransaction = true
                } label: {
                    Text("Buy").frame(maxWidth: .infinity)
                }.tint(Color("Green"))
            }.buttonStyle(.borderedProminent)
                .padding(20)
        }.sheet(isPresented: $showTransaction) {
            Transaction(userViewModel: UserViewModel(manager: CoreDataManager(context: viewContext), context: viewContext), showTransaction: $showTransaction, transactionType: $transactionType, asset: asset)
                .presentationDetents([.fraction(0.4)])
        }
    }
}

struct TransactionButtons_Previews: PreviewProvider {
    static var previews: some View {
        TransactionButtons(asset: Asset(id: "test", symbol: "test", name: "test", image: "test", currentPrice: 0.0, priceChange24H: 0.0))
    }
}
