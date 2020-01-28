//
//  WeatherModel.swift
//  Clima
//
//  Created by hollywoodno on 1/27/20.
//  Copyright © 2020 App Brewery. All rights reserved.
//

struct WeatherModel {
  let conditionId: Int
  let cityName: String
  var temperature: Double
  
  var temperatureString: String {
    return String(format: "%.1f", temperature)
  }
  
  var conditionName: String {
    switch conditionId {
    case 200...232:
      return "cloud.bolt"
    case 300...321:
      return "cloud.drizzle"
    case 500...531:
      return "cloud.rain"
    case 600...622:
      return "cloud.snow"
    case 701...781:
      return "cloud.fog"
    case 800:
      return "sun.max"
    case 801...804:
      return "cloud.bolt"
    default:
      return "cloud"
    }
  }
}
