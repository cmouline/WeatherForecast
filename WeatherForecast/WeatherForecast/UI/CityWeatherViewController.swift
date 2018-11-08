//
//  CityWeatherViewController.swift
//  WeatherForecast
//
//  Created by Moulinet Chloë on 07/11/2018.
//  Copyright © 2018 Moulinet Chloë. All rights reserved.
//

import UIKit
import SwiftyJSON

class CityWeatherViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableview: UITableView!
    
    var weatherData: JSON?
    var iconData: [UIImage]?

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
        
        if let weatherData = weatherData?["list"][indexPath.row], let iconData = iconData {
            cell.weatherIconImageView.image = iconData[indexPath.row]

            if let timestamp = weatherData["dt"].double {
                cell.mainInformationsLabel.text = DateHelper.formatTimestamp(timestamp, format: .fullDateTime)
            }
            
            let weatherInfo = weatherData["weather"][0]
            
            if let temperature = weatherData["main"]["temp"].double?.description,
                let mainInfo = weatherInfo["main"].string,
                let descriptionInfo = weatherInfo["description"].string {
                cell.textDescriptionLabel.text = "🌡 \(temperature) º\(RequestManager.shared.degreeUnit.string) - \(mainInfo): \(descriptionInfo)"
            }
        }

        return cell
    }
    
}
