//
//  Goal.swift
//  Habbit
//
//  Created by 김상혁 on 2023/04/09.
//

import Foundation

struct Goal {
    let name: String
    let category: GoalCategory
    let aimedPeriod: [DailyTask]
    
    var startDate: Date {
        aimedPeriod.first?.date ?? Date()
    }
    
    var endDate: Date {
        aimedPeriod.last?.date ?? Date()
    }
    
    func toDTO() -> GoalDTO {
        return GoalDTO(
            goalName: name,
            categoryName: category.index,
            startDate: startDate.formattedString,
            endDate: endDate.formattedString
        )
    }
}
