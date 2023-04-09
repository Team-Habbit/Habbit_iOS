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
    let startDate: String
    let endDate: String
}
