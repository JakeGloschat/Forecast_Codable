//
//  Constants.swift
//  Forecast_Codable
//
//  Created by iMac Pro on 2/27/23.
//

import Foundation

struct Constants {
    
    struct WeatherURL {
        static let baseURL          = "https://api.weatherbit.io/v2.0/forecast/daily"
        static let cityQueryKey     = "city"
        static let cityQueryValue   = "Highland+Village,TX"
        static let unitsQueryKey    = "units"
        static let unitsQueryValue  = "I"
        static let apiQueryKey      = "key"
        static let apiQueryValue    = "fff2218d88514062ad8aa6cb02375e1e"
    }
}
