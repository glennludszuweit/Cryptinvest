//
//  API.swift
//  WorkingWithAPI-SwiftUI
//
//  Created by Glenn Ludszuweit on 24/04/2023.
//

import Foundation

struct API {
    static let coingeckoApi: String = "https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&order=market_cap_desc&per_page=100&page=1&sparkline=true&price_change_percentage=24h"
    static let coingeckoGetCoinApi: String = "https://api.coingecko.com/api/v3/coins/"
    static let coingeckoGetCoinApiQuery: String = "?localization=false&tickers=false&market_data=true&community_data=false&developer_data=false&sparkline=true"
}
