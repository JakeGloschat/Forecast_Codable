//
//  NetworkController.swift
//  Forecast_Codable
//
//  Created by iMac Pro on 2/27/23.
//

import Foundation

class NetworkController {
    
    static func fetchDays(completion: @escaping (TopLevelDictionary?) -> Void) {
        guard let baseURL = URL(string: Constants.WeatherURL.baseURL) else { completion(nil) ; return }
        var urlComponents = URLComponents(url: baseURL, resolvingAgainstBaseURL: true)
        
        let cityQuery = URLQueryItem(name: Constants.WeatherURL.cityQueryKey, value: Constants.WeatherURL.cityQueryValue)
        let unitQuery = URLQueryItem(name: Constants.WeatherURL.unitsQueryKey, value: Constants.WeatherURL.unitsQueryValue)
        let apiQuery = URLQueryItem(name: Constants.WeatherURL.apiQueryKey, value: Constants.WeatherURL.apiQueryValue)
        urlComponents?.queryItems = [cityQuery, unitQuery, apiQuery]
        
        guard let finalURL = urlComponents?.url else { completion(nil) ; return }
        print("Final URL: \(finalURL)")
        
        URLSession.shared.dataTask(with: finalURL) { dayData, _, error in
            if let error = error {
                print("There was an error fetching the data. The Final URL is \(finalURL). The error is: \(error.localizedDescription)")
                completion(nil)
                return
            }
            
            guard let data = dayData else { print("There was an error receiving the data.") ; completion(nil) ; return }
            do {
                let topLevelDictionary = try JSONDecoder().decode(TopLevelDictionary.self, from: data)
                completion(topLevelDictionary)
            } catch {
                print("Error in Do/Try/Catch: \(error.localizedDescription)")
                completion(nil)
            }
        }.resume()
    }
} //: CLASS
