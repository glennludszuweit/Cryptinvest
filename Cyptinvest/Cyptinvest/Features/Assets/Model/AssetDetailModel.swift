//
//  AssetDetailModel.swift
//  Cyptinvest
//
//  Created by Glenn Ludszuweit on 19/05/2023.
//

import Foundation

struct AssetDetail: Codable, Identifiable {
    let id, symbol, name: String?
    let blockTimeInMinutes: Int?
    let hashingAlgorithm: String?
    let description: Description?
    let image: DetailsImage?
    let links: Links?
    let marketData: MarketData?
    
    enum CodingKeys: String, CodingKey {
        case id, symbol, name, description, links, image
        case blockTimeInMinutes = "block_time_in_minutes"
        case hashingAlgorithm = "hashing_algorithm"
        case marketData = "market_data"
    }
    
    var readableDescription: String? {
        return description?.en
    }
}

struct DetailsImage: Codable {
    let thumb: String?
    let large: String?
    let small: String?
}

struct Links: Codable {
    let homepage: [String]?
    let subredditURL: String?
    
    enum CodingKeys: String, CodingKey {
        case homepage
        case subredditURL = "subreddit_url"
    }
}

struct Description: Codable {
    let en: String?
}

struct MarketData: Codable {
    let currentPrice: [String:Double]?
    let priceChangePercentage24h: Double?
    let sparkLine7D: SparklineIn7D?
    let marketCap: [String:Double]?
    let totalVolume: [String:Double]?
    let fullyDilutedValuation: [String:Double]?
    let circulatingSupply: Double?
    let totalSupply: Double?
    let maxSupply: Double?
    
    enum CodingKeys: String, CodingKey {
        case currentPrice = "current_price"
        case priceChangePercentage24h = "price_change_percentage_24h"
        case sparkLine7D = "sparkline_7d"
        case marketCap = "market_cap"
        case totalVolume = "total_volume"
        case fullyDilutedValuation = "fully_diluted_valuation"
        case circulatingSupply = "circulating_supply"
        case totalSupply = "total_supply"
        case maxSupply = "max_supply"
    }
}
