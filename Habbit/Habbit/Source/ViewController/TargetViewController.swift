//
//  TargetViewController.swift
//  Habbit
//
//  Created by 박현준 on 2023/04/08.
//

import UIKit
import SnapKit

//selector ~~buttondidtap

class TargetViewController: UIViewController {

//MARK: - Components
    var targetString: String = ""
    var categoryClicked: String = ""
    var isCategoryButtonClicked = false
    
//MARK: - UI Components
    
    let categoryLabel: UILabel = {
        $0.text = "목표에 해당하는 카테고리를 설정해주세요!"
        $0.font = UIFont.cafe24Ssurround(size: 20)
        $0.textColor = UIColor.black
        $0.numberOfLines = 0
        $0.textAlignment = .center
        return $0
    }(UILabel())
    
    let categoryButton1: UIButton = {
        $0.setTitle("# 내면적 성장을 위해서\n(책읽기, 명상하기, 일기쓰기 등)", for: .normal)
        $0.titleLabel?.lineBreakMode = .byWordWrapping
        $0.titleLabel?.textAlignment = .center
        $0.setTitleColor(.black, for: .normal)
        $0.layer.cornerRadius = 15
        $0.backgroundColor = UIColor.white
        $0.layer.borderWidth = 1
        $0.layer.borderColor = UIColor.black.cgColor
        $0.isSelected = false
        return $0
    }(UIButton())
    
    
    
    let categoryButton2: UIButton = {
        $0.setTitle("# 생산성을 위해서\n(공부, 어학, 비즈니스 스킬 등)", for: .normal)
        $0.titleLabel?.lineBreakMode = .byWordWrapping
        $0.titleLabel?.textAlignment = .center
        $0.setTitleColor(.black, for: .normal)
        $0.layer.cornerRadius = 15
        $0.backgroundColor = UIColor.white
        $0.layer.borderWidth = 1
        $0.layer.borderColor = UIColor.black.cgColor
        $0.isSelected = false
        return $0
    }(UIButton())
    
    let categoryButton3: UIButton = {
        $0.setTitle("# 건강을 위해서\n(식습관 개선, 물 마시기, 등산 등)", for: .normal)
        $0.titleLabel?.lineBreakMode = .byWordWrapping
        $0.titleLabel?.textAlignment = .center
        $0.setTitleColor(.black, for: .normal)
        $0.layer.cornerRadius = 15
        $0.backgroundColor = UIColor.white
        $0.layer.borderWidth = 1
        $0.layer.borderColor = UIColor.black.cgColor
        $0.isSelected = false
        return $0
    }(UIButton())
    
//    let categoryButton3: UIButton = {
//        var attributedString = NSMutableAttributedString(string: "# 건강을 위해서\n(식습관 개선, 물 마시기, 등산 등)")
//        attributedString.addAttribute(.font, value: UIFont.notoSansBold(size: 17), range: NSRange(location: 0, length: 10))
//        attributedString.addAttribute(.font, value: UIFont.notoSansRegular(size: 10), range: NSRange(location: 11, length: 5))
//        attributedString.addAttribute(.foregroundColor, value: UIColor.black, range: NSRange(location: 0, length: attributedString.length))
//        $0.setAttributedTitle(attributedString, for: .normal)
//        $0.layer.cornerRadius = 15
//        $0.backgroundColor = UIColor.white
//        $0.isSelected = false
//        return $0
//    }(UIButton())
    
    let nextButton: UIButton = {
        var attributedString = NSMutableAttributedString(string: "확인")
        attributedString.addAttribute(.font, value: UIFont.pretendardBold(size: 16), range: NSRange(location: 0, length: attributedString.length))
        attributedString.addAttribute(.foregroundColor, value: UIColor.white, range: NSRange(location: 0, length: attributedString.length))
        $0.setAttributedTitle(attributedString, for: .normal)
        $0.layer.cornerRadius = 16
        $0.backgroundColor = UIColor.gray
        $0.isEnabled = false
        return $0
    }(UIButton())

    
//MARK: - Life Cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setUI()
        buttonTarget()
    }
    
    func buttonTarget() {
        categoryButton1.addTarget(self, action: #selector(buttonClicked(_:)), for: .touchUpInside)
        categoryButton2.addTarget(self, action: #selector(buttonClicked(_:)), for: .touchUpInside)
        categoryButton3.addTarget(self, action: #selector(buttonClicked(_:)), for: .touchUpInside)

        nextButton.addTarget(self, action: #selector(buttonClicked(_:)), for: .touchUpInside)
    }
    
    
//MARK: - set UI
    func setUI() {
        view.addSubview(categoryLabel)
        view.addSubview(categoryButton1)
        view.addSubview(categoryButton2)
        view.addSubview(categoryButton3)
        view.addSubview(nextButton)
        
        categoryLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).inset(120)
            make.leading.trailing.equalToSuperview().inset(40)
        }
        categoryButton1.snp.makeConstraints { make in
            make.top.equalTo(categoryLabel.snp.bottom).inset(-40)
            make.centerX.equalToSuperview()
            make.width.equalTo(283)
            make.height.equalTo(68)
        }
        categoryButton2.snp.makeConstraints { make in
            make.top.equalTo(categoryButton1.snp.bottom).inset(-11)
            make.centerX.equalToSuperview()
            make.width.equalTo(283)
            make.height.equalTo(68)
        }
        categoryButton3.snp.makeConstraints { make in
            make.top.equalTo(categoryButton2.snp.bottom).inset(-11)
            make.centerX.equalToSuperview()
            make.width.equalTo(283)
            make.height.equalTo(68)
        }
        nextButton.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide).inset(15)
            make.leading.trailing.equalToSuperview().inset(20)
            make.height.equalTo(60)
        }
    }
    
//MARK: - function

    @objc func buttonClicked(_ sender: UIButton) {
        
        if sender == categoryButton1 {
            if isCategoryButtonClicked == false {
                sender.isSelected = true
                sender.layer.borderColor = UIColor.habbitYellow.cgColor
                isCategoryButtonClicked = true
                categoryClicked = "내면적 성장을 위해서"
                sender.backgroundColor = UIColor.habbitYellow
                categoryButton2.isEnabled = false
                categoryButton3.isEnabled = false
            } else {
                sender.isSelected = false
                sender.layer.borderColor = UIColor.black.cgColor
                isCategoryButtonClicked = false
                categoryClicked = ""
                sender.backgroundColor = UIColor.white
                categoryButton2.isEnabled = true
                categoryButton3.isEnabled = true
            }
        } else if sender == categoryButton2 {
            if isCategoryButtonClicked == false {
                sender.layer.borderColor = UIColor.habbitYellow.cgColor
                sender.isSelected = true
                isCategoryButtonClicked = true
                categoryClicked = "생산성 향상을 위해서"
                sender.backgroundColor = UIColor.habbitYellow
                categoryButton1.isEnabled = false
                categoryButton3.isEnabled = false
            } else {
                sender.isSelected = false
                sender.layer.borderColor = UIColor.black.cgColor
                isCategoryButtonClicked = false
                categoryClicked = ""
                sender.backgroundColor = UIColor.white
                categoryButton1.isEnabled = true
                categoryButton3.isEnabled = true
            }
        } else if sender == categoryButton3 {
            if isCategoryButtonClicked == false {
                sender.layer.borderColor = UIColor.habbitYellow.cgColor
                sender.isSelected = true
                isCategoryButtonClicked = true
                categoryClicked = "건강을 위해서"
                sender.backgroundColor = UIColor.habbitYellow
                categoryButton1.isEnabled = false
                categoryButton2.isEnabled = false
            } else {
                sender.isSelected = false
                sender.layer.borderColor = UIColor.black.cgColor
                isCategoryButtonClicked = false
                categoryClicked = ""
                sender.backgroundColor = UIColor.white
                categoryButton1.isEnabled = true
                categoryButton2.isEnabled = true
            }
        } else if sender == nextButton {
            // nextButton 실행코드
            print("\(targetString)과 \(categoryClicked)")
        }
        
        
        if isCategoryButtonClicked == true {
            nextButton.isEnabled = true
            nextButton.backgroundColor = UIColor.habbitBlack
        } else {
            nextButton.isEnabled = false
            nextButton.backgroundColor = UIColor.gray
        }
        
    }
    
}
