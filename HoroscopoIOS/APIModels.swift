//
//  APIModels.swift
//  HoroscopoIOS
//
//  Created by Tardes on 13/12/24.
//

import Foundation

struct APIResponse: Decodable {
    let data: HoroscopeData
    let status: Int
    let success: Bool
}

struct HoroscopeData: Decodable {
    let date: String
    let horoscopeData: String

    private enum CodingKeys: String, CodingKey {
        case date
        case horoscopeData = "horoscope_data"
    }
}
