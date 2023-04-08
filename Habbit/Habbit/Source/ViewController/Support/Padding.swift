//
//  Padding.swift
//  Habbit
//
//  Created by 김상혁 on 2023/04/08.
//

import UIKit.UIGeometry

enum Padding {
    case small
    case medium
    case large
    case custom(top: CGFloat, left: CGFloat, bottom: CGFloat, right: CGFloat)
    
    var insets: UIEdgeInsets {
        switch self {
        case .small:
            return UIEdgeInsets(top: 4, left: 8, bottom: 4, right: 8)
        case .medium:
            return UIEdgeInsets(top: 8, left: 16, bottom: 8, right: 16)
        case .large:
            return UIEdgeInsets(top: 12, left: 20, bottom: 12, right: 20)
        case .custom(let top, let left, let bottom, let right):
            return UIEdgeInsets(top: top, left: left, bottom: bottom, right: right)
        }
    }
}
