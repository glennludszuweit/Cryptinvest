//
//  DetailsChart.swift
//  Cyptinvest
//
//  Created by Glenn Ludszuweit on 21/05/2023.
//

import SwiftUI

struct DetailsChart: View {
    @State var data: [Double] = []
    @State var maxY: Double = 0
    @State var minY: Double = 0
    @State var priceChange: Double = 0
    var asset: Asset
    
    var body: some View {
        GeometryReader { geometry in
            Path { path in
                for index in data.indices {
                    let yAxis = maxY - minY
                    let xPosition = geometry.size.width / CGFloat(data.count) * CGFloat(index + 1)
                    let yPosition = (1 - CGFloat((data[index] - minY) / yAxis)) * geometry.size.height
                    
                    if index == 0 {
                        path.move(to: CGPoint(x: xPosition, y: yPosition))
                    }
                    path.addLine(to: CGPoint(x: xPosition, y: yPosition))
                }
            }.stroke(priceChange > 0 ? Color("Green") : Color("Red"), style: StrokeStyle(lineWidth: 2, lineCap: .round, lineJoin: .round))
        }.frame(height: 250)
            .onAppear {
                data = asset.sparklineIn7D?.price ?? []
                maxY = data.max() ?? 0
                minY = data.min() ?? 0
                priceChange = (data.last ?? 0) - (data.first ?? 0)
            }
    }
}

struct DetailsChart_Previews: PreviewProvider {
    static var previews: some View {
        DetailsChart(asset: Asset(id: "test", symbol: "test", name: "test", image: "test", currentPrice: 0.0))
    }
}
