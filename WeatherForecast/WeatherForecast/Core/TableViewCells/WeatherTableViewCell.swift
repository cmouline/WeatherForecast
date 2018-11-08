//
//  WeatherTableViewCell.swift
//  WeatherForecast
//
//  Created by Moulinet Chloë on 07/11/2018.
//  Copyright © 2018 Moulinet Chloë. All rights reserved.
//

import UIKit

class WeatherTableViewCell: UITableViewCell {

    @IBOutlet weak var weatherIconImageView: UIImageView!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var informationsLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()

        setup()
    }
    
    func setup() {
        dateLabel.adjustsFontSizeToFitWidth = true
        informationsLabel.adjustsFontSizeToFitWidth = true
    }

}
