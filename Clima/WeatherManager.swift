//
//  WeatherManager.swift
//  Clima
//
//  Created by hollywoodno on 1/26/20.
//  Copyright © 2020 App Brewery. All rights reserved.
//

import Foundation

struct WeatherManager {
  
  let base_url = "https://api.openweathermap.org/data/2.5/weather?appid=0d1d0cc444542e1eadab470a051235f2&units=imperial"
  
  func fetchWeather(cityName: String) {
    let urlString = "\(base_url)&q=\(cityName)"
    print("Weather response: \(urlString)")
    
    if let url = URL(string: urlString) {
      let session = URLSession(configuration: .default)
      
      let task = session.dataTask(with: url) { (data, response, error) in
        if error != nil {
          print("Error retrieving weather data: \(error!)")
          return
        }
        
        if let weatherData = data {
          //          let dataString = String(data: weatherData, encoding: .utf8)
          //          print("Weather data retrieved \(String(describing: dataString))")
          self.parseJSON(data: weatherData)
        }
      }
      
      task.resume()
    }
  }
  
  func parseJSON(data: Data) {
    let decoder = JSONDecoder()
    
    do {
      let weatherData = try decoder.decode(WeatherData.self, from: data)
      
      let id = weatherData.weather.first!.id
      let temp = weatherData.main.temp
      let cityName = weatherData.name
      
      let weather = WeatherModel(conditionId: id, cityName: cityName, temperature: temp)
      
      print("Temperature String: \(weather.temperatureString)")
    } catch {
      print("Error fetching weather data: \(error)")
    }
  }
}
