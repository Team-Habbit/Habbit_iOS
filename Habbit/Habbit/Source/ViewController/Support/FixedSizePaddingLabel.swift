//
//  FixedSizePaddingLabel.swift
//  Habbit
//
//  Created by 김상혁 on 2023/04/09.
//

import UIKit

class FixedSizePaddingLabel: PaddingLabel {
    private var initialSize: CGSize?
    
    override var intrinsicContentSize: CGSize {
        if initialSize == nil {
            initialSize = super.intrinsicContentSize
        }
        return initialSize ?? super.intrinsicContentSize
    }
}
