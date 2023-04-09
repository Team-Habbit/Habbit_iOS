//
//  FinishViewController.swift
//  Habbit
//
//  Created by 박현준 on 2023/04/09.
//

import UIKit
import SnapKit

class FinishViewController: UIViewController {
//MARK: - UI Components
    let backgroundImageView: UIImageView = {
        $0.image = UIImage(named: "finishBackground")
        return $0
    }(UIImageView())
    
    let helloLabel: UILabel = {
        $0.text = "완료"
        $0.font = UIFont.cafe24Ssurround(size: 48)
        $0.textColor = UIColor.habbitBlack
        $0.textAlignment = .center
        return $0
    }(UILabel())
    
    let finishHabbitImageView: UIImageView = {
        $0.image = UIImage(named: "finishHabbit")
        return $0
    }(UIImageView())
    
    let finishHabbitTextOne: FixedSizePaddingLabel = {
        let label = FixedSizePaddingLabel(padding: .custom(top: 10, left: 21, bottom: 10, right: 21))
        label.text = "덕분에 물을 좋아하게 됐어"
        label.font = UIFont.pretendardRegular(size: 17)
        label.textColor = UIColor.white
        label.backgroundColor = UIColor.habbitBlack
        label.layer.cornerRadius = 20
        label.layer.masksToBounds = true
        label.textAlignment = .center
        return label
    }()
    
    let finishHabbitTextTwo: FixedSizePaddingLabel = {
        let label = FixedSizePaddingLabel(padding: .custom(top: 10, left: 21, bottom: 10, right: 21))
        label.text = "정말 고마워!"
        label.font = UIFont.pretendardRegular(size: 17)
        label.textColor = UIColor.white
        label.backgroundColor = UIColor.habbitBlack
        label.layer.cornerRadius = 20
        label.layer.masksToBounds = true
        label.textAlignment = .center
        return label
    }()
    
    let finishButton: UIButton = {
        var attributedString = NSMutableAttributedString(string: "완료")
        attributedString.addAttribute(.font, value: UIFont.pretendardBold(size: 18), range: NSRange(location: 0, length: attributedString.length))
        attributedString.addAttribute(.foregroundColor, value: UIColor.white, range: NSRange(location: 0, length: attributedString.length))
        $0.setAttributedTitle(attributedString, for: .normal)
        $0.layer.cornerRadius = 16
        $0.backgroundColor = UIColor.habbitBlack
        return $0
    }(UIButton())
    
//MARK: - Life Cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setUI()
        finishButton.addTarget(self, action: #selector(finishButtonDidTap), for: .touchUpInside)
    }
  
    
    @objc func finishButtonDidTap() {
        self.dismiss(animated: true)
    }
    
    
//MARK: - set UI
    func setUI() {
        view.addSubview(backgroundImageView)
        backgroundImageView.addSubview(helloLabel)
        backgroundImageView.addSubview(finishHabbitImageView)
        backgroundImageView.addSubview(finishHabbitTextOne)
        backgroundImageView.addSubview(finishHabbitTextTwo)
        view.addSubview(finishButton)
        
        backgroundImageView.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.bottom.equalTo(finishButton.snp.top)
        }
        finishHabbitImageView.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
        helloLabel.snp.makeConstraints { make in
            make.bottom.equalTo(finishHabbitImageView.snp.top).inset(45)
            make.centerX.equalToSuperview()
        }
        finishHabbitTextOne.snp.makeConstraints { make in
            make.top.equalTo(finishHabbitImageView.snp.bottom).inset(15)
            make.centerX.equalToSuperview()
        }
        finishHabbitTextTwo.snp.makeConstraints { make in
            make.top.equalTo(finishHabbitTextOne.snp.bottom).inset(-20)
            make.centerX.equalToSuperview()
        }
        finishButton.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide).inset(15)
            make.leading.trailing.equalToSuperview().inset(20)
            make.height.equalTo(60)
        }
    }
}
