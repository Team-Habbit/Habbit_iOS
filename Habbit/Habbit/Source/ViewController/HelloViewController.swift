//
//  HelloViewController.swift
//  Habbit
//
//  Created by 박현준 on 2023/04/08.
//

import UIKit
import SnapKit

class HelloViewController: UIViewController {

    let helloLabel: UILabel = {
        $0.text = "안녕하세요!"
        $0.font = UIFont.cafe24Ssurround(size: 20)
        $0.textColor = UIColor.black
        $0.textAlignment = .center
        return $0
    }(UILabel())
    
    let nextButton: UIButton = {
        var attributedString = NSMutableAttributedString(string: "네")
        attributedString.addAttribute(.font, value: UIFont.notoSansBold(size: 16), range: NSRange(location: 0, length: attributedString.length))
        attributedString.addAttribute(.foregroundColor, value: UIColor.white, range: NSRange(location: 0, length: attributedString.length))
        $0.setAttributedTitle(attributedString, for: .normal)
        $0.layer.cornerRadius = 16
        $0.backgroundColor = UIColor.habbitBlack
        return $0
    }(UIButton())
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setUI()
        
        nextButton.addTarget(self, action: #selector(nextButtonDidTap), for: .touchUpInside)
    }
    
    func setUI() {
        view.addSubview(helloLabel)
        view.addSubview(nextButton)
        
        helloLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
        nextButton.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide).inset(15)
            make.leading.trailing.equalToSuperview().inset(20)
            make.height.equalTo(60)
        }
    }
    
    @objc func nextButtonDidTap() {
        print("찍힘")
        let vc = GoalViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }

}
