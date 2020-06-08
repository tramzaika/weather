//
//  ViewController.swift
//  weather
//
//  Created by liza on 26/04/2020.
//  Copyright © 2020 liza. All rights reserved.
//

import UIKit
import CoreLocation

class ViewController: UIViewController {
    
    
    @IBOutlet var weatherIconImageView: UIImageView!
    @IBOutlet var cityLabel: UILabel!
    @IBOutlet var temperatureLabel: UILabel!
    @IBOutlet var feelsLikeTemperatureLabel: UILabel!
    
    var networkWeatherManager = NetworkWeatherManager()
    lazy var locationManager: CLLocationManager = {
        let lm = CLLocationManager()
        lm.delegate = self
        lm.desiredAccuracy = kCLLocationAccuracyKilometer
        lm.requestWhenInUseAuthorization()
        return lm
    }()
    
    @IBAction func searchPressed(_ sender: UIButton) {
        self.preasentSearchAlertController(withTitle: "Enter city name", message: nil, style: .alert) {
            [unowned self] cityName in
            self.networkWeatherManager.fetchCurrentWeather(forCity: cityName)
            
        }
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        networkWeatherManager.onCompletion = {[weak self] currentWeather in
            guard let self = self else {return}
            self.updateInterfaceWith(weather: currentWeather)
        }
        
        if CLLocationManager.locationServicesEnabled(){
            locationManager.requestLocation()
        }
   }
    func updateInterfaceWith(weather: CurrentWeather) {
        DispatchQueue.main.async {
        self.cityLabel.text = weather.cityName
        self.temperatureLabel.text = weather.temperatureString
        self.feelsLikeTemperatureLabel.text = weather.feelsLiketemperatureString
        self.weatherIconImageView.image = UIImage(systemName: weather.systemIconNameString)
        }
    }
}
    //MARK: - CLLocationManagerDelegate
    
    extension ViewController: CLLocationManagerDelegate{
        func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
            guard let location = locations.last else { return }
            let lalitude = location.coordinate.latitude
            let longitude = location.coordinate.longitude
            
            networkWeatherManager.fetchCurrentWeather(latitude: lalitude, longitude: longitude)
        }
        
        func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
            print(error.localizedDescription)
        }
    }


