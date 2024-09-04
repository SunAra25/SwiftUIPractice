//
//  CoinAPI.swift
//  SwiftUIPractice
//
//  Created by 아라 on 9/4/24.
//

import Foundation

typealias Markets = [Market]

struct CoinAPI {
    
    private init() { }

    static func fetchMarket() async throws -> Markets {
        let url = URL(string: "https://api.upbit.com/v1/market/all")!
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        let decodedData = try JSONDecoder().decode(Markets.self, from: data)
        
        return decodedData
    }
}

struct Market: Hashable, Codable {
    let market, koreanName, englishName: String
    var isLike = false

    enum CodingKeys: String, CodingKey {
        case market
        case koreanName = "korean_name"
        case englishName = "english_name"
    }
}
