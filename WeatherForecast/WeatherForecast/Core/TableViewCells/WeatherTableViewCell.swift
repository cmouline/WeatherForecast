//
//  WeatherTableViewCell.swift
//  WeatherForecast
//
//  Created by Moulinet Chloë on 07/11/2018.
//  Copyright © 2018 Moulinet Chloë. All rights reserved.
//

import UIKit

struct weatherCellData {
    var imageURL: String
    var mainInformations: String
    var textDescription: String
}

class WeatherTableViewCell: UITableViewCell {

    @IBOutlet weak var weatherIconImageView: UIImageView!
    @IBOutlet weak var mainInformationsLabel: UILabel!
    @IBOutlet weak var textDescriptionLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()

        setup()
    }
    
    func setup() {
        mainInformationsLabel.adjustsFontSizeToFitWidth = true
        textDescriptionLabel.adjustsFontSizeToFitWidth = true
    }
//
//    override func setSelected(_ selected: Bool, animated: Bool) {
//        super.setSelected(selected, animated: animated)
//
//        // Configure the view for the selected state
//    }

}
