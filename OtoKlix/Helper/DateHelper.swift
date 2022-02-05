//
//  DateHelper.swift
//  OtoKlix
//
//  Created by Phincon on 05/02/22.
//

import Foundation
import UIKit

class DateHelper {
    static let shared = DateHelper()
    
    func convertDateStringToDate(date: String) -> String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSSZ"
        let yourDate = dateFormatter.date(from: date)

        // change to local time zone from your format
        dateFormatter.dateFormat = "dd MMMM yyyy HH:mm:ss"
        dateFormatter.timeZone = TimeZone.current
        let dateString = dateFormatter.string(from: yourDate ?? Date())
        return dateString
    }
    
}

extension String {

    func convertDateStringToDate(date: String) -> String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSSZ"
        let yourDate = dateFormatter.date(from: date)

        // change to local time zone from your format
        dateFormatter.dateFormat = "dd MMMM yyyy HH:mm:ss"
        dateFormatter.timeZone = TimeZone.current
        let dateString = dateFormatter.string(from: yourDate ?? Date())
        return dateString
    }
}

