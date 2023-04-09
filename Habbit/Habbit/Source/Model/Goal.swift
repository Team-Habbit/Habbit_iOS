//
//  Goal.swift
//  Habbit
//
//  Created by 김상혁 on 2023/04/09.
//

import Foundation

final class Goal {
    let userName: String
    let name: String
    let category: GoalCategory
    let aimedPeriod: [DailyTask]
    
    var startDate: Date {
        aimedPeriod.first?.date ?? Date()
    }
    
    var endDate: Date {
        aimedPeriod.last?.date ?? Date()
    }
    
    init(userName: String, name: String, category: GoalCategory, aimedPeriod: [DailyTask]) {
        self.userName = userName
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
    
}
