//
//  HelloViewController.swift
//  Habbit
//
//  Created by 박현준 on 2023/04/08.
//

import UIKit
import SnapKit

class HelloViewController: UIViewController {

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
    
//MARK: - UI Components
    let helloLabel: UILabel = {
        $0.text = "안녕하세요!\n당신의 이름을 알려주세요"
        $0.font = UIFont.cafe24Ssurround(size: 20)
        $0.textColor = UIColor.black
        $0.textAlignment = .center
        $0.numberOfLines = .zero
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
    private var userName: String?
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        targetTextField.becomeFirstResponder()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        targetTextField.resignFirstResponder()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        targetTextField.delegate = self
        setUI()
        nextButton.addTarget(self, action: #selector(nextButtonDidTap), for: .touchUpInside)
    }
    
//MARK: - set UI
    func setUI() {
        view.addSubview(helloLabel)
        view.addSubview(targetInputView)
        targetInputView.addSubview(targetTextField)
        view.addSubview(nextButton)
        
        helloLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview().offset(-48)
        }
        targetInputView.snp.makeConstraints { make in
            make.top.equalTo(helloLabel.snp.bottom).offset(16)
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
    
    @objc func nextButtonDidTap() {
        let vc = GoalViewController()
        vc.userName = textfieldString
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        textfieldString = textField.text ?? ""
        print(textfieldString)
    }
    
}

extension HelloViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        targetTextField.resignFirstResponder()
        return true
    }
}
