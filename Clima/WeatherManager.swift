//
//  WeatherManager.swift
//  Clima
//
//  Created by hollywoodno on 1/26/20.
//  Copyright © 2020 App Brewery. All rights reserved.
//

import Foundation

protocol WeatherManagerDelegate {
  func didUpdateWeather(_ weather: WeatherModel)
}

struct WeatherManager {
  
  let base_url = "https://api.openweathermap.org/data/2.5/weather?appid=0d1d0cc444542e1eadab470a051235f2&units=imperial"
  var delegate: WeatherManagerDelegate?
  
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
          let weather = self.parseJSON(data: weatherData)
          
          // the weather object is ready
          if let weather = weather {
            self.delegate?.didUpdateWeather(weather)
          }
        }
      }
      
      task.resume()
    }
  }
  
  func parseJSON(data: Data)-> WeatherModel? {
    let decoder = JSONDecoder()
    
    do {
      let weatherData = try decoder.decode(WeatherData.self, from: data)
      
      let id = weatherData.weather.first!.id
      let temp = weatherData.main.temp
      let cityName = weatherData.name
      
      let weather = WeatherModel(conditionId: id, cityName: cityName, temperature: temp)
      
      return weather
    } catch {
      print("Error fetching weather data: \(error)")
      return nil
    }
  }
}
