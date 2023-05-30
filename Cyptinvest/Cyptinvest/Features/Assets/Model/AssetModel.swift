//
//  Assets.swift
//  Cyptinvest
//
//  Created by Glenn Ludszuweit on 17/05/2023.
//

import Foundation

struct Asset: Identifiable, Codable {
    var id, symbol, name: String
    var image: String
    var currentPrice: Double
    var marketCap, marketCapRank, fullyDilutedValuation: Double?
    var totalVolume, high24H, low24H: Double?
    var priceChange24H: Double?
    var priceChangePercentage24H: Double?
    var marketCapChange24H: Double?
    var marketCapChangePercentage24H: Double?
    var circulatingSupply, totalSupply, maxSupply, ath: Double?
    var athChangePercentage: Double?
    var athDate: String?
    var atl, atlChangePercentage: Double?
    var atlDate: String?
    var lastUpdated: String?
    var sparklineIn7D: SparklineIn7D?
    var priceChangePercentage24HInCurrency: Double?
    var currentHoldings: Double?
    
    enum CodingKeys: String, CodingKey {
        case id, symbol, name, image
        case currentPrice = "current_price"
        case marketCap = "market_cap"
        case marketCapRank = "market_cap_rank"
        case fullyDilutedValuation = "fully_diluted_valuation"
        case totalVolume = "total_volume"
        case high24H = "high_24h"
        case low24H = "low_24h"
        case priceChange24H = "price_change_24h"
        case priceChangePercentage24H = "price_change_percentage_24h"
        case marketCapChange24H = "market_cap_change_24h"
        case marketCapChangePercentage24H = "market_cap_change_percentage_24h"
        case circulatingSupply = "circulating_supply"
        case totalSupply = "total_supply"
        case maxSupply = "max_supply"
        case ath
        case athChangePercentage = "ath_change_percentage"
        case athDate = "ath_date"
        case atl
        case atlChangePercentage = "atl_change_percentage"
        case atlDate = "atl_date"
        case lastUpdated = "last_updated"
        case sparklineIn7D = "sparkline_in_7d"
        case priceChangePercentage24HInCurrency = "price_change_percentage_24h_in_currency"
        case currentHoldings
    }
    
    var currentHoldingsValue: Double {
        return (currentHoldings ?? 0) * currentPrice
    }
}

struct SparklineIn7D: Codable {
    let price: [Double]?
}
