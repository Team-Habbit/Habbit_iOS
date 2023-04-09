//
//  UIColor.swift
//  Habbit
//
//  Created by 박현준 on 2023/04/08.
//

import UIKit

extension UIColor {
    static let habbitYellow = UIColor.rgb(red: 249, green: 196, blue: 105)
    static let habbitLightYellow = UIColor.rgb(red: 255, green: 200 , blue: 105)
    static let habbitBlack = UIColor.rgb(red: 56, green: 56, blue: 56)
    
}

// RGB값을 받아서 UIColor를 리턴하는 함수
extension UIColor {
    static func rgb(red: CGFloat, green: CGFloat, blue: CGFloat) -> UIColor {
        return UIColor(red: red/255, green: green/255, blue: blue/255, alpha: 1)
    }
}

