//
//  WeatherData.swift
//  Clima
//
//  Created by hollywoodno on 1/26/20.
//  Copyright © 2020 App Brewery. All rights reserved.
//

struct WeatherData: Decodable {
  let name: String
  let main: Main
  let weather: [Weather]
}

struct Main: Decodable {
  let temp: Double
}

struct Weather: Decodable {
  let id: Int
  let description: String
}
