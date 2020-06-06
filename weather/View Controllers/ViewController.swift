//
//  ViewController.swift
//  weather
//
//  Created by liza on 26/04/2020.
//  Copyright © 2020 liza. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    
    @IBOutlet var weatherIconImageView: UIImageView!
    @IBOutlet var cityLabel: UILabel!
    @IBOutlet var temperatureLabel: UILabel!
    @IBOutlet var feelsLikeTemperatureLabel: UILabel!
    
    var networkWeatherManager = NetworkWeatherManager()
    
    @IBAction func searchPressed(_ sender: UIButton) {
        self.preasentSearchAlertController(withTitle: "Enter city name", message: nil, style: .alert) { cityName in
            self.networkWeatherManager.fetchCurrentWeather(forCity: cityName)
            
        }
        
    }
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        networkWeatherManager.onCompletion = { CurrentWeather in
            print(CurrentWeather.cityName)
        }
        
        networkWeatherManager.fetchCurrentWeather(forCity: "London")
        
   }


}

