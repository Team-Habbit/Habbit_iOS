//  GoalViewController.swift
//  Habbit
//
//  Created by 박현준 on 2023/04/08.
//

import UIKit
import SnapKit

class GoalViewController: UIViewController {

    var textfieldString = "" {
        didSet {
            if !textfieldString.isEmpty {
                nextButton.isEnabled = true
                nextButton.backgroundColor = .habbitBlack
            } else {
                nextButton.isEnabled = false
                nextButton.backgroundColor = .gray
            }
        }
    }
//MARK: - Components
    var userName = ""
    
    
//MARK: - UI Components
    private let indicateImage: UIImageView = {
        $0.image = UIImage(named: "startOne")
        return $0
    }(UIImageView())
    
    private let targetItemImage: UIImageView = {
        $0.image = UIImage(named: "targetItem")
        return $0
    }(UIImageView())
    
    let targetLabel: UILabel = {
        $0.text = "어떤 목표를 설정하고 싶으신가요?"
        $0.font = UIFont.cafe24Ssurround(size: 20)
        $0.textColor = UIColor.black
        $0.textAlignment = .center
        return $0
    }(UILabel())
    
    let targetInputView: UIView = {
        $0.backgroundColor = UIColor.white
        $0.layer.borderWidth = 1
        $0.layer.borderColor = UIColor.black.cgColor
        $0.layer.cornerRadius = 12
        return $0
    }(UIView())
    
    let targetTextField: UITextField = {
        $0.backgroundColor = .clear
        $0.clearButtonMode = .whileEditing
        $0.autocapitalizationType = .none
        $0.spellCheckingType = .no
        $0.smartDashesType = .no
        $0.autocorrectionType = .no
        $0.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        return $0
    }(UITextField())
    
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
        setNavigationBarButton()
        targetTextField.delegate = self
        nextButton.addTarget(self, action: #selector(nextButtonDidTap), for: .touchUpInside)
        print("Goal : \(userName)")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        targetTextField.becomeFirstResponder()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        targetTextField.resignFirstResponder()
    }
    //MARK: - set UI
    func setUI() {
        view.addSubview(indicateImage)
        view.addSubview(targetItemImage)
        view.addSubview(targetLabel)
        view.addSubview(targetInputView)
        targetInputView.addSubview(targetTextField)
        view.addSubview(nextButton)
        
        indicateImage.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).inset(5)
            make.centerX.equalToSuperview()
            make.width.equalTo(170)
            make.height.equalTo(40)
        }
        targetItemImage.snp.makeConstraints { make in
            make.top.equalTo(indicateImage.snp.bottom).inset(-40)
            make.centerX.equalToSuperview()
            make.width.equalTo(255)
            make.height.equalTo(155)
        }
        targetLabel.snp.makeConstraints { make in
            make.top.equalTo(targetItemImage.snp.bottom).inset(-40)
            make.centerX.equalToSuperview()
        }
        targetInputView.snp.makeConstraints { make in
            make.top.equalTo(targetLabel.snp.bottom).inset(-20)
            make.leading.trailing.equalToSuperview().inset(35)
            make.height.equalTo(53)
            
        }
        targetTextField.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.trailing.equalToSuperview().inset(20)
        }
        nextButton.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide).inset(15)
            make.leading.trailing.equalToSuperview().inset(20)
            make.height.equalTo(60)
        }
    }
    
    func setNavigationBarButton() {
        navigationItem.backButtonTitle = "목표 재설정"
        navigationController?.navigationBar.tintColor = .darkGray
    }
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        textfieldString = textField.text ?? ""
        print(textfieldString)
    }
    
    @objc func nextButtonDidTap() {
        let vc = TargetViewController()
        vc.userName = userName
        vc.targetString = textfieldString
        navigationController?.pushViewController(vc, animated: true)
    }
}

// MARK: - Keyboard
extension GoalViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        targetTextField.resignFirstResponder()
        return true
    }
}
