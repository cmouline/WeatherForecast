//
//  SearchPresenter.swift
//  WeatherForecast
//
//  Created by Moulinet Chloë on 07/11/2018.
//  Copyright © 2018 Moulinet Chloë. All rights reserved.
//

import UIKit
import SwiftyJSON
import MapKit

class SearchPresenter {
    
    weak var view: SearchViewController!

    required init(view: SearchViewController) {
        self.view = view
    }

    func touchSubmit(city: String) {
        
        view.showLoader()
        view.dismissKeyboard()
        
        RequestManager.shared.requestBy(cityName: city) { [weak self] json in
            // if json["list"].isEmpty == request failed
            guard !json["list"].isEmpty else {
                self?.view.showAlert()
                self?.view.hideLoader()
                return
            }

            self?.prepareData(with: json)
        }
    }
    
    func prepareData(with json: JSON) {
        // Collect weather icons and store them
        var iconData: [UIImage] = []
        json["list"].forEach { elem in
            let url = URL(string: "https://openweathermap.org/img/w/\(elem.1["weather"][0]["icon"]).png")
            do {
                let data = try Data(contentsOf: url!)
                if let image = UIImage(data: data) {
                    iconData.append(image)
                }
            } catch {
                view.showAlert()
                view.hideLoader()
                print("Error getting weather icon : \(error)")
            }
        }
        
        // Set CityWeatherViewController with data successfully collected and push VC
        let destination: CityWeatherViewController = view.storyboard?.instantiateViewController(withIdentifier: "cityWeatherViewController") as! CityWeatherViewController
        destination.weatherData = json
        destination.iconData = iconData
        
        view.hideLoader()
        view.pushCityWeatherViewController(destination: destination)
    }
    
    @objc func degreeUnitSelectorValueChanged(_ sender: UISegmentedControl) {
        RequestManager.shared.degreeUnit = degreeUnit(rawValue: sender.selectedSegmentIndex)!
    }
    
    @objc func touchMap(_ gestureReconizer: UITapGestureRecognizer) {
        let location = gestureReconizer.location(in: view.mapView)
        let coordinate = view.mapView.convert(location,toCoordinateFrom: view.mapView)

        view.showLoader()

        RequestManager.shared.requestBy(coordinates: coordinate) { [weak self] json in
            // if json["list"].isEmpty == request failed
            guard !json["list"].isEmpty else {
                self?.view.showAlert()
                self?.view.hideLoader()
                return
            }
            
            self?.prepareData(with: json)
        }
    }
}
