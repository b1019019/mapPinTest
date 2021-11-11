//
//  OpenWeatherData.swift
//  mapPinTest
//
//  Created by 山田純平 on 2021/10/13.
//

import Foundation
struct OpenWeatherData: Decodable {
    struct weather: Decodable {
        let id: Int
        let main: String
        let description: String
        let icon: String
    }
    let weather: [weather]
}
