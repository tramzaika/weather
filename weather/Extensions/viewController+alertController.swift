//
//  viewController+alertController.swift
//  weather
//
//  Created by liza on 07/05/2020.
//  Copyright © 2020 liza. All rights reserved.
//

import UIKit

extension ViewController {
    func preasentSearchAlertController(withTitle title: String?, message: String?, style: UIAlertController.Style, complitionHandler: @escaping (String)-> Void  ){
        let ac = UIAlertController(title: title, message: message, preferredStyle: style)
        ac.addTextField { tf in
            let cities = ["San Fracisco", "Omsk", "Gdansk", "Stambul", "Viena"]
            tf.placeholder = cities.randomElement()
        }
        let search = UIAlertAction(title: "Search", style: .default) { action in
            let textField = ac.textFields?.first
            guard let cityName = textField?.text else { return }
            if cityName != "" {
                let city = cityName.split(separator: " ").joined(separator: "%20")
                complitionHandler(city)
               // print ("search info the \(cityName)")
            }
        }
        let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)

        ac.addAction(search)
        ac.addAction(cancel)
        present(ac, animated: true, completion: nil)
    }
}
