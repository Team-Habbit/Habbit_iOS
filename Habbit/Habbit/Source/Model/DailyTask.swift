//
//  DailyTask.swift
//  Habbit
//
//  Created by 김상혁 on 2023/04/09.
//

import Foundation

struct DailyTask {
    let date: Date
    let isCompleted: Bool
    
    func isCompleted(of date: Date) -> Bool {
        if self.date == date {
            return isCompleted
        } else {
            return false
        }
        
    }
}
