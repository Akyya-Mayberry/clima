//
//  ViewController.swift
//  Clima
//
//  Created by Angela Yu on 01/09/2019.
//  Copyright © 2019 App Brewery. All rights reserved.
//

import UIKit

class WeatherViewController: UIViewController, UITextFieldDelegate, WeatherManagerDelegate {
  
  // MARK: - Properties
  
  @IBOutlet weak var conditionImageView: UIImageView!
  @IBOutlet weak var temperatureLabel: UILabel!
  @IBOutlet weak var cityLabel: UILabel!
  @IBOutlet weak var searchTextField: UITextField!
  
  var weatherManager = WeatherManager()
  
  // MARK: - Methods

  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view.
    
    searchTextField.delegate = self
    weatherManager.delegate = self
  }
  
  @IBAction func searchPressed(_ sender: UIButton) {
    searchTextField.endEditing(true)
    print(searchTextField.text!)
  }
  
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
  
  func didUpdateWeather(_ weather: WeatherModel) {
    DispatchQueue.main.async {
      self.temperatureLabel.text = weather.temperatureString
      self.conditionImageView.image = UIImage(systemName: weather.conditionName)
    }
  }
  
  func didFailWithError(_ error: Error) {
    print("Fetching weather failed: \(error)")
  }
}

