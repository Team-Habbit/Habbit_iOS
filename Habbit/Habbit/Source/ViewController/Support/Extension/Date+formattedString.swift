//
//  Date+formattedString.swift
//  Habbit
//
//  Created by 김상혁 on 2023/04/09.
//

import Foundation

extension Date {
    var formattedString: String {
        let dateFormatter = DateFormatter()
        
        dateFormatter.dateFormat = "yyyy-MM-dd"
        return dateFormatter.string(from: self)
    }
    
    var koreanDate: Date {
        let now = self
        let timeZone = TimeZone(identifier: "Asia/Seoul")!
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = timeZone
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let koreanDateString = dateFormatter.string(from: now)
        let koreanDate = dateFormatter.date(from: koreanDateString)!
        return koreanDate
    }
}
