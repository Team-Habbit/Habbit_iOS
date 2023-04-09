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
        dateFormatter.dateFormat = "yyyy년 MM월 dd일"
        return dateFormatter.string(from: self)
    }
}
