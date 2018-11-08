//
//  CityWeatherViewController.swift
//  WeatherForecast
//
//  Created by Moulinet Chloë on 07/11/2018.
//  Copyright © 2018 Moulinet Chloë. All rights reserved.
//

import UIKit
import SwiftyJSON
import Kingfisher

class CityWeatherViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableview: UITableView!
    
    let iconUrl = "https://openweathermap.org/img/w/%@.png"
    var weatherData: JSON?

    override func viewDidLoad() {
        super.viewDidLoad()

        tableview.delegate = self
        tableview.dataSource = self
        
        setup()
    }
    
    func setup() {
        if let weatherData = weatherData {
            self.navigationItem.title = weatherData["city"]["name"].string
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let weatherData = weatherData {
           return weatherData["list"].count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "weatherCell", for: indexPath) as! WeatherTableViewCell
        
        if let weatherData = weatherData?["list"][indexPath.row] {
            
            // Get weather icon and cache it with Kingfisher
            if let iconRef = weatherData["weather"][0]["icon"].string,
               let url = URL(string: String(format: iconUrl, iconRef)) {
                cell.weatherIconImageView.kf.setImage(with: url)
            }
            
            // Set date and time label
            if let timestamp = weatherData["dt"].double {
                cell.dateLabel.text = DateHelper.formatTimestamp(timestamp, format: .fullDateTime)
            }
            
            // Set textual informations and temperature
            let weatherInfo = weatherData["weather"][0]
            
            if let temperature = weatherData["main"]["temp"].double?.description,
               let mainInfo = weatherInfo["main"].string,
               let descriptionInfo = weatherInfo["description"].string {
                cell.informationsLabel.text = "\(mainInfo): \(descriptionInfo) 🌡 \(temperature) º\(RequestManager.shared.degreeUnit.description)"
            }
        }

        return cell
    }
    
}
