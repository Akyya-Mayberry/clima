//
//  ViewController.swift
//  Clima
//
//  Created by Angela Yu on 01/09/2019.
//  Copyright © 2019 App Brewery. All rights reserved.
//

import UIKit
import CoreLocation

class WeatherViewController: UIViewController {
  
  // MARK: - Properties
  
  @IBOutlet weak var conditionImageView: UIImageView!
  @IBOutlet weak var temperatureLabel: UILabel!
  @IBOutlet weak var cityLabel: UILabel!
  @IBOutlet weak var searchTextField: UITextField!
  
  var weatherManager = WeatherManager()
  let locationManager = CLLocationManager()
  
  // MARK: - Methods
  
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view.
    
    searchTextField.delegate = self
    weatherManager.delegate = self
    locationManager.delegate = self
    
    // request location
    locationManager.requestWhenInUseAuthorization()
    locationManager.requestLocation()
  }
  
  @IBAction func searchPressed(_ sender: UIButton) {
    searchTextField.endEditing(true)
    print(searchTextField.text!)
  }

  @IBAction func currentLocationPressed(_ sender: UIButton) {
    // stop location services if running to ensure request location is called
    locationManager.stopUpdatingLocation()
    locationManager.requestLocation()
  }

}

// MARK: - Extensions

// MARK: - TextField Delegate

extension WeatherViewController: UITextFieldDelegate {
  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    searchTextField.endEditing(true)
    print(searchTextField.text!)
    return true
  }
  
  func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
    if textField.text != "" {
      return true
    } else {
      textField.placeholder = "Type something"
      return false
    }
  }
  
  func textFieldDidEndEditing(_ textField: UITextField) {
    if let city = textField.text {
      weatherManager.fetchWeather(for: city)
    }
    searchTextField.text = ""
  }
}

// MARK: - Weather Manager Delegate

extension WeatherViewController: WeatherManagerDelegate {
  func didUpdateWeather(_ weather: WeatherModel) {
    DispatchQueue.main.async {
      self.temperatureLabel.text = weather.temperatureString
      self.conditionImageView.image = UIImage(systemName: weather.conditionName)
      self.cityLabel.text = weather.cityName
    }
  }
  
  func didFailWithError(_ error: Error) {
    print("Fetching weather failed: \(error)")
  }
}

// MARK: - CLLocation Manager Delegate

extension WeatherViewController: CLLocationManagerDelegate {
  func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
    if let location = locations.last {
      let lat = location.coordinate.latitude
      let long = location.coordinate.longitude
      weatherManager.fetchWeather(lat: lat, long: long)
    }
  }
  
  func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
    print("Error fetching users current location: \(error)")
  }
}
