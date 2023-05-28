//
//  TransactionView.swift
//  Cyptinvest
//
//  Created by Glenn Ludszuweit on 24/05/2023.
//

import SwiftUI
import CoreData

struct TransactionView: View {
    @StateObject var userViewModel: UserViewModel
    @State var quantity: Double = 0
    @State var holdings: Double = 0
    @Binding var showTransaction: Bool
    @Binding var transactionType: String
    
    @Environment(\.managedObjectContext) private var viewContext
    
    var asset: Asset
    var body: some View {
        VStack {
            HStack {
                Spacer()
                Text(String(format: "Holdings: %.2f", transactionType == "Sell" ? holdings - quantity : holdings + quantity))
                    .foregroundColor(Color("Black"))
                    .font(.subheadline).fontWeight(.semibold)
            }.padding(20)
            Group {
                TextField("Amount", value: ($quantity), formatter: NumberFormatter())
                    .keyboardType(.numberPad)
                    .textFieldStyle(.roundedBorder)
                    .frame(maxWidth: .infinity)
                    .onChange(of: quantity) { newValue in
                        if "\(newValue)".count == 0 {
                            quantity = 0
                        }
                    }
                
                
                HStack {
                    Group {
                        if transactionType == "Sell" {
                            Text("\(((userViewModel.userData.first?.usd ?? 0) + (asset.currentPrice * quantity)).formatted(.currency(code: "USD")))")
                        } else {
                            Text("\(((userViewModel.userData.first?.usd ?? 0) - (asset.currentPrice * quantity)).formatted(.currency(code: "USD")))")
                        }
                        
                        Spacer()
                        Text("\((asset.currentPrice * quantity).formatted(.currency(code: "USD")))")
                    }.font(.subheadline).fontWeight(.semibold)
                }.offset(y: -25)
            }.padding()
                .foregroundColor(Color("Black"))
            Spacer()
            Button(action: {
                Task {
                    await userViewModel.updatePortfolio(asset:asset, amount: quantity, context: viewContext, operation: transactionType)
                    showTransaction = false
                }
            }, label: {
                Text(transactionType).frame(maxWidth: .infinity)
            })
            .tint(transactionType == "Buy" ? Color("Green") : Color("Red"))
            .padding(25)
            .buttonStyle(.borderedProminent)
        }.onAppear {
            holdings = asset.currentHoldings ?? 0
        }
    }
}

//struct TransactionView_Previews: PreviewProvider {
//    static var previews: some View {
//        TransactionView(userViewModel: UserViewModel(manager: CoreDataManager(context: TransactionView.context)), showTransaction: .constant(false), transactionType: .constant(""), asset: Asset(id: "test", symbol: "test", name: "test", image: "test", currentPrice: 0.0, priceChange24H: 0.0))
//    }
//}
