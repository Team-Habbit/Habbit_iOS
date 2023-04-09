//
//  GoalDTO.swift
//  Habbit
//
//  Created by 김상혁 on 2023/04/09.
//

import Foundation

struct GoalDTO: Codable {
    let goalName: String
    let categoryName: String
    let period: [Date]
    let endDate: Date
}
