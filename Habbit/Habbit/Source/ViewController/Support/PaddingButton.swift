//
//  PaddingButton.swift
//  Habbit
//
//  Created by 김상혁 on 2023/04/08.
//

import UIKit.UIButton

class PaddingButton: UIButton {
    
    private let padding: UIEdgeInsets
    
    init(padding: Padding = .medium) {
        self.padding = padding.insets
        super.init(frame: .zero)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect.inset(by: padding))
    }
    
    override var intrinsicContentSize: CGSize {
        var contentSize = super.intrinsicContentSize
        if contentSize == .zero { return contentSize }
        contentSize.height += padding.top + padding.bottom
        contentSize.width += padding.left + padding.right
        return contentSize
    }
}


class RoundButton: UIButton {
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.clipsToBounds = true
        self.layer.cornerRadius = min(self.frame.width, self.frame.height) / 2
    }
}


