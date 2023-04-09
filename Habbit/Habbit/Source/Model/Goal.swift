//
//  Goal.swift
//  Habbit
//
//  Created by 김상혁 on 2023/04/09.
//

import Foundation

final class Goal {
    let name: String
    let category: GoalCategory
    let aimedPeriod: [DailyTask]
    
    var startDate: Date {
        aimedPeriod.first?.date ?? Date()
    }
    
    var endDate: Date {
        aimedPeriod.last?.date ?? Date()
    }
    
    init(name: String, category: GoalCategory, aimedPeriod: [DailyTask]) {
        self.name = name
        self.category = category
        self.aimedPeriod = aimedPeriod
    }
    
    func complete(today: Date) {
        let targetDate = aimedPeriod.first {
            $0.date.formattedString == today.formattedString
        }
        
        targetDate?.isCompleted = true
    }
    
//    func toDTO() -> GoalDTO {
//        return GoalDTO(
//            goalName: name,
//            categoryName: category.index,
//            startDate: startDate.formattedString,
//            endDate: endDate.formattedString
//        )
//    }
}
