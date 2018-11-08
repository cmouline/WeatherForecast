//
//  RequestManager.swift
//  WeatherForecast
//
//  Created by Moulinet Chloë on 07/11/2018.
//  Copyright © 2018 Moulinet Chloë. All rights reserved.
//

import Alamofire
import SwiftyJSON

enum degreeUnit: Int {
    
    /*
    ** Keep cases in the same order as they are presented in segmented control
    */
    case celsius
    case fahrenheit
    case kelvin
    
    var requestType: String {
        switch self {
        case .celsius:
            return "metric"
        case .fahrenheit:
            return "imperial"
        case .kelvin:
            return "standard"
        }
    }
    
    var string: String {
        switch self {
        case .celsius:
            return "C"
        case .fahrenheit:
            return "F"
        case .kelvin:
            return "K"
        }
    }
}

class RequestManager {
    
    static let shared = RequestManager()
    
    let apiWeatherRequest = "https://api.openweathermap.org/data/2.5/forecast?"
    let requestByName = "q="
    let withUnitType = "&units="
    let requestWithToken = "&appid="
    let apiToken = "f7c339ad65e6adc72c66c9f7b55ad380"
    
    var degreeUnit: degreeUnit = .celsius
    
    func requestBy(cityName: String, completion: @escaping ((JSON) -> Void)) {
        // Remove all non alphabetical characters
        let cleanCityName = cityName.filter { "abcdefghijklmnopqrstuvwxyz ".contains($0) }
        let requestURL =    apiWeatherRequest +
                            requestByName +
                            cleanCityName.replacingOccurrences(of: " ", with: "%20") +
                            withUnitType +
                            degreeUnit.requestType +
                            requestWithToken + apiToken
        
        Alamofire.request(requestURL).responseJSON { response in
            if let data = response.data {
                do {
                    let jsonData = try JSON(data: data)
                    completion(jsonData)
                } catch {
                    print("Error \(error)")
                }
            }
        }
    }
}
