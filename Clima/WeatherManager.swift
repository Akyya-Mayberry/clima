//
//  WeatherManager.swift
//  Clima
//
//  Created by hollywoodno on 1/26/20.
//  Copyright © 2020 App Brewery. All rights reserved.
//

import Foundation

struct WeatherManager {
  
  let base_url = "http://api.openweathermap.org/data/2.5/weather?appid=0d1d0cc444542e1eadab470a051235f2&units=metric"
  
  func fetchWeather(cityName: String) {
    let url = "\(base_url)&q=\(cityName)"
    print("Weather response: \(url)")
  }
}
