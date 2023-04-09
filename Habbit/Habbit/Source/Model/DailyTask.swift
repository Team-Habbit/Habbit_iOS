//
//  DailyTask.swift
//  Habbit
//
//  Created by 김상혁 on 2023/04/09.
//

import Foundation

final class DailyTask {
    let date: Date
    var isCompleted: Bool
    
    init(date: Date, isCompleted: Bool) {
        self.date = date
        self.isCompleted = isCompleted
    }
        
    func isCompleted(of date: Date) -> Bool {
        if self.date == date {
            return isCompleted
        } else {
            return false
        }
    }
}
