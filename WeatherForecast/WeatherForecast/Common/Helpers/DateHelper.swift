//
//  DateHelper.swift
//  WeatherForecast
//
//  Created by Moulinet Chloë on 07/11/2018.
//  Copyright © 2018 Moulinet Chloë. All rights reserved.
//

import Foundation

enum CustomDateFormat {
    case fullDateTime
    case textDate
    case numberedDate
    case time
    
    var string: String {
        switch self {
        case .fullDateTime:
            return "EEEE dd MMMM - HH:mm"
        case .numberedDate :
            return "MM/dd/yyyy"
        case .textDate :
            return "EEEE dd MMMM"
        case .time :
            return "HH:mm"
        }
    }
}

class DateHelper {
    
    static func formatTimestamp(_ timestamp: TimeInterval, format: CustomDateFormat) -> String {
        
        let date = Date(timeIntervalSince1970: timestamp)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format.string
        
        return dateFormatter.string(from: date)
    }
    
}
