//
//  AssetDetailModel.swift
//  Cyptinvest
//
//  Created by Glenn Ludszuweit on 19/05/2023.
//

import Foundation

struct AssetDetail: Codable {
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
    
    enum CodingKeys: String, CodingKey {
        case currentPrice = "current_price"
    }
}
