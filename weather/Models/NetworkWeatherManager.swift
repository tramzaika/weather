//
//  NetworkWeatherManager.swift
//  weather
//
//  Created by liza on 11/05/2020.
//  Copyright © 2020 liza. All rights reserved.
//

import Foundation
import CoreLocation

class NetworkWeatherManager {
    
    var onCompletion:((CurrentWeather) -> Void)?
    
    func fetchCurrentWeather(forCity city: String){
        let urlString = "https://api.openweathermap.org/data/2.5/weather?q=\(city)&appid=\(apiKey)&units=metric"
      urlWork(urlString: urlString)
    }
    func fetchCurrentWeather(latitude: CLLocationDegrees, longitude: CLLocationDegrees){
          let urlString = "https://api.openweathermap.org/data/2.5/weather?lat=\(latitude)&lon=\(longitude)&appid=\(apiKey)&units=metric"
        urlWork(urlString: urlString)
      }
   fileprivate func urlWork(urlString: String){
    guard let url = URL(string: urlString) else {return}
        let session = URLSession(configuration: .default)

        let task = session.dataTask(with: url) { data, response, error in
            if let data = data {
                if let currentWeather = self.parseJSON(withData: data){
                    self.onCompletion?(currentWeather)
                }
        }
        }
        task.resume()
    }
       
    
    func parseJSON(withData data: Data) -> CurrentWeather? {
        let decoder = JSONDecoder()
        do{
            let currentWeatherData = try decoder.decode(CurrentWeatherData.self, from: data)
            guard let currentWeather = CurrentWeather(currentWeatherData: currentWeatherData) else {
                return nil
            }
            return currentWeather
         //   print(currentWeatherData.main.temp)
        } catch let error as NSError {
            print(error.localizedDescription)
        }
        return nil
    }
    
}
