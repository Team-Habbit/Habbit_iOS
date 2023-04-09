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
        let firstLine = "# 내면적 성장을 위해서"
        let secondLine = "(책읽기, 명상하기, 일기쓰기 등)"
        let firstLineAttributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.black,
            .font: UIFont.pretendardBold(size: 17)]
        let firstLineAttributedString = NSAttributedString(string: firstLine, attributes: firstLineAttributes)
        let secondLineAttributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.black,
            .font: UIFont.pretendardRegular(size: 15)]
        let secondLineAttributedString = NSAttributedString(string: secondLine, attributes: secondLineAttributes)
        let combinedString = NSMutableAttributedString()
        combinedString.append(firstLineAttributedString)
        combinedString.append(NSAttributedString(string: "\n"))
        combinedString.append(secondLineAttributedString)
        $0.titleLabel?.numberOfLines = 0
        $0.titleLabel?.textAlignment = .left
        $0.setAttributedTitle(combinedString, for: .normal)
        
        $0.layer.cornerRadius = 15
        $0.backgroundColor = UIColor.white
        $0.layer.borderWidth = 1
        $0.layer.borderColor = UIColor.black.cgColor
        $0.isSelected = false
        return $0
    }(UIButton())
    
    let categoryButton2: UIButton = {
        let firstLine = "# 생산성을 위해서"
        let secondLine = "(공부, 어학, 비즈니스 스킬 등)"
        let firstLineAttributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.black,
            .font: UIFont.pretendardBold(size: 17)]
        let firstLineAttributedString = NSAttributedString(string: firstLine, attributes: firstLineAttributes)
        let secondLineAttributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.black,
            .font: UIFont.pretendardRegular(size: 15)]
        let secondLineAttributedString = NSAttributedString(string: secondLine, attributes: secondLineAttributes)
        let combinedString = NSMutableAttributedString()
        combinedString.append(firstLineAttributedString)
        combinedString.append(NSAttributedString(string: "\n"))
        combinedString.append(secondLineAttributedString)
        $0.titleLabel?.numberOfLines = 0
        $0.titleLabel?.textAlignment = .left
        $0.setAttributedTitle(combinedString, for: .normal)
        
        $0.layer.cornerRadius = 15
        $0.backgroundColor = UIColor.white
        $0.layer.borderWidth = 1
        $0.layer.borderColor = UIColor.black.cgColor
        $0.isSelected = false
        return $0
    }(UIButton())
    
    let categoryButton3: UIButton = {
        let firstLine = "# 건강을 위해서"
        let secondLine = "(식습관 개선, 물 마시기, 등산 등)"
        let firstLineAttributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.black,
            .font: UIFont.pretendardBold(size: 17)]
        let firstLineAttributedString = NSAttributedString(string: firstLine, attributes: firstLineAttributes)
        let secondLineAttributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.black,
            .font: UIFont.pretendardRegular(size: 15)]
        let secondLineAttributedString = NSAttributedString(string: secondLine, attributes: secondLineAttributes)
        let combinedString = NSMutableAttributedString()
        combinedString.append(firstLineAttributedString)
        combinedString.append(NSAttributedString(string: "\n"))
        combinedString.append(secondLineAttributedString)
        $0.titleLabel?.numberOfLines = 0
        $0.titleLabel?.textAlignment = .center
        $0.setAttributedTitle(combinedString, for: .normal)
        
        $0.titleLabel?.numberOfLines = 0
        $0.titleLabel?.textAlignment = .left
        $0.setAttributedTitle(combinedString, for: .normal)
        $0.layer.cornerRadius = 15
        $0.backgroundColor = UIColor.white
        $0.layer.borderWidth = 1
        $0.layer.borderColor = UIColor.black.cgColor
        $0.isSelected = false
        return $0
    }(UIButton())
    
    let nextButton: UIButton = {
        var attributedString = NSMutableAttributedString(string: "다음 단계로")
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
            make.bottom.equalTo(categoryButton1.snp.top).inset(-40)
            make.leading.trailing.equalToSuperview().inset(40)
        }
        categoryButton1.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.width.equalTo(283)
            make.height.equalTo(68)
            make.bottom.equalTo(categoryButton2.snp.top).inset(-11)
        }
        categoryButton2.snp.makeConstraints { make in
            make.bottom.equalTo(categoryButton3.snp.top).inset(-11)
            make.centerX.equalToSuperview()
            make.width.equalTo(283)
            make.height.equalTo(68)
        }
        categoryButton3.snp.makeConstraints { make in
            make.bottom.equalTo(nextButton.snp.top).inset(-50)
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
            } else {
                if categoryButton2.isSelected == true || categoryButton3.isSelected == true {
                    categoryButton2.isSelected = false
                    categoryButton3.isSelected = false
                    categoryButton2.layer.borderColor = UIColor.black.cgColor
                    categoryButton3.layer.borderColor = UIColor.black.cgColor
                    categoryButton2.backgroundColor = UIColor.white
                    categoryButton3.backgroundColor = UIColor.white
                    categoryClicked = "내면적 성장을 위해서"
                    sender.isSelected = true
                    sender.layer.borderColor = UIColor.habbitYellow.cgColor
                    sender.backgroundColor = UIColor.habbitYellow
                } else {
                    sender.isSelected = false
                    sender.layer.borderColor = UIColor.black.cgColor
                    isCategoryButtonClicked = false
                    categoryClicked = ""
                    sender.backgroundColor = UIColor.white
                }
            }
        } else if sender == categoryButton2 {
            if isCategoryButtonClicked == false {
                sender.layer.borderColor = UIColor.habbitYellow.cgColor
                sender.isSelected = true
                isCategoryButtonClicked = true
                categoryClicked = "생산성 향상을 위해서"
                sender.backgroundColor = UIColor.habbitYellow

            } else {
                if categoryButton1.isSelected == true || categoryButton3.isSelected == true {
                    categoryButton1.isSelected = false
                    categoryButton3.isSelected = false
                    categoryButton1.layer.borderColor = UIColor.black.cgColor
                    categoryButton3.layer.borderColor = UIColor.black.cgColor
                    categoryButton1.backgroundColor = UIColor.white
                    categoryButton3.backgroundColor = UIColor.white
                    categoryClicked = "생산성 향상을 위해서"
                    sender.isSelected = true
                    sender.layer.borderColor = UIColor.habbitYellow.cgColor
                    sender.backgroundColor = UIColor.habbitYellow
                } else {
                    sender.isSelected = false
                    sender.layer.borderColor = UIColor.black.cgColor
                    isCategoryButtonClicked = false
                    categoryClicked = ""
                    sender.backgroundColor = UIColor.white
                }
            }
        } else if sender == categoryButton3 {
            if isCategoryButtonClicked == false {
                sender.layer.borderColor = UIColor.habbitYellow.cgColor
                sender.isSelected = true
                isCategoryButtonClicked = true
                categoryClicked = "건강을 위해서"
                sender.backgroundColor = UIColor.habbitYellow
                
            } else {
                if categoryButton1.isSelected == true || categoryButton2.isSelected == true {
                    categoryButton1.isSelected = false
                    categoryButton2.isSelected = false
                    categoryButton1.layer.borderColor = UIColor.black.cgColor
                    categoryButton2.layer.borderColor = UIColor.black.cgColor
                    categoryButton1.backgroundColor = UIColor.white
                    categoryButton2.backgroundColor = UIColor.white
                    categoryClicked = "건강을 위해서"
                    sender.isSelected = true
                    sender.layer.borderColor = UIColor.habbitYellow.cgColor
                    sender.backgroundColor = UIColor.habbitYellow
                } else {
                    sender.isSelected = false
                    sender.layer.borderColor = UIColor.black.cgColor
                    isCategoryButtonClicked = false
                    categoryClicked = ""
                    sender.backgroundColor = UIColor.white
                }
                
            }
        } else if sender == nextButton {
            // nextButton 실행코드
            print("\(targetString)과 \(categoryClicked)")
            let vc = HomeViewController()
            navigationController?.pushViewController(vc, animated: true)
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
