//
//  GoalCategory.swift
//  Habbit
//
//  Created by 김상혁 on 2023/04/09.
//

import Foundation

enum GoalCategory {
    case selfDevelopment
    case productivity
    case wellness
    
    var index: String {
        switch self {
        case .selfDevelopment:
            return "0"
        case .productivity:
            return "1"
        case .wellness:
            return "2"
        }
    }
}
