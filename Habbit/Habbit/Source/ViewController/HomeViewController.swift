//
//  HomeViewController.swift
//  Habbit
//
//  Created by 박현준 on 2023/04/09.
//

import UIKit
import SnapKit

class HomeViewController: UIViewController {

//MARK: - UI Components
    let backgroundSrcollView: UIScrollView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.backgroundColor = .white
        $0.showsVerticalScrollIndicator = false
        $0.isScrollEnabled = true
        return $0
    }(UIScrollView())
    
    let titleLabel: UILabel = {
        $0.text = "나의 목표"
        $0.font = UIFont.cafe24Ssurround(size: 20)
        $0.textColor = UIColor.black
        $0.textAlignment = .center
        return $0
    }(UILabel())
    
    var goalLabel: FixedSizePaddingLabel = {
        let label = FixedSizePaddingLabel(padding: .custom(top: 12, left: 20, bottom: 12, right: 20))
        label.text = "하루에 물 한잔씩 마시기"
        label.font = UIFont.pretendardRegular(size: 19)
        label.textColor = UIColor.black
        label.backgroundColor = UIColor.habbitLightYellow
        label.layer.cornerRadius = 13
        label.layer.masksToBounds = true
        label.textAlignment = .center
        return label
    }()
    
    let firstMessageLabel: FixedSizePaddingLabel = {
        let label = FixedSizePaddingLabel(padding: .custom(top: 10, left: 18, bottom: 10, right: 18))
        label.text = "오늘 하루도 힘내!"
        label.font = UIFont.pretendardRegular(size: 17)
        label.textColor = UIColor.white
        label.backgroundColor = UIColor.habbitBlack
        label.layer.cornerRadius = 20
        label.layer.masksToBounds = true
        label.textAlignment = .center
        return label
    }()
    
    let deliciousMessageLabel: FixedSizePaddingLabel = {
        let label = FixedSizePaddingLabel(padding: .custom(top: 10, left: 18, bottom: 10, right: 18))
        label.text = "너무 맛있어!"
        label.font = UIFont.pretendardRegular(size: 17)
        label.textColor = UIColor.white
        label.backgroundColor = UIColor.habbitBlack
        label.layer.cornerRadius = 20
        label.layer.masksToBounds = true
        label.textAlignment = .center
        label.isHidden = true
        return label
    }()
    
    let secondMessageLabel: FixedSizePaddingLabel = {
        let label = FixedSizePaddingLabel(padding: .custom(top: 10, left: 18, bottom: 10, right: 18))
        label.text = "밥은 먹고 하자~"
        label.font = UIFont.pretendardRegular(size: 17)
        label.textColor = UIColor.white
        label.backgroundColor = UIColor.habbitBlack
        label.layer.cornerRadius = 20
        label.layer.masksToBounds = true
        label.textAlignment = .center
        return label
    }()
    
    let thanksLabel: FixedSizePaddingLabel = {
        let label = FixedSizePaddingLabel(padding: .custom(top: 10, left: 18, bottom: 10, right: 18))
        label.text = "챙겨줘서 고마워"
        label.font = UIFont.pretendardRegular(size: 17)
        label.textColor = UIColor.white
        label.backgroundColor = UIColor.habbitBlack
        label.layer.cornerRadius = 20
        label.layer.masksToBounds = true
        label.textAlignment = .center
        label.isHidden = true
        return label
    }()
    
    var habbitImageView: UIImageView = {
//        $0.image = UIImage(named: "habbit_full")
        $0.image = UIImage(named: "habbit")
        return $0
    }(UIImageView())
    
    let carrotHolder: UIImageView = {
        $0.image = UIImage(named: "carrotHolder")
        return $0
    }(UIImageView())
    
    var carrotButton: UIButton = {
        $0.setImage(UIImage(named: "carrot"), for: .normal)
        return $0
    }(UIButton())
    
    let eatCarrotLabel: UILabel = {
        $0.text = "당근 주기"
        $0.font = UIFont.cafe24Ssurround(size: 17)
        $0.textColor = UIColor.black
        $0.textAlignment = .center
        return $0
    }(UILabel())
    
    let totalLabel: UILabel = {
        $0.text = "총 달성률"
        $0.font = UIFont.cafe24Ssurround(size: 17)
        $0.textColor = UIColor.black
        $0.textAlignment = .center
        return $0
    }(UILabel())
    
    let totalImageView: UIImageView = {
        $0.image = UIImage(named: "total")
        return $0
    }(UIImageView())
    
    let recentLabel: UILabel = {
        $0.text = "최근 7일동안 준 당근 개수"
        $0.font = UIFont.cafe24Ssurround(size: 17)
        $0.textColor = UIColor.black
        $0.textAlignment = .center
        return $0
    }(UILabel())
    
    private var goal: Goal
    
    init(goal: Goal) {
        self.goal = goal
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
//MARK: - Life Cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setUI()
        setUpBarButton()
        backgroundSrcollView.contentSize = CGSize(width: view.frame.width, height: view.frame.height * 2 - 200)
        carrotButton.addTarget(self, action: #selector(carrotButtonDidTap), for: .touchUpInside)
    }
    
//MARK: - set UI
    func setUpBarButton() {
        let calendarBarbutton = UIBarButtonItem(
            image: UIImage(named: "calendar")?
                .withTintColor(.habbitBlack, renderingMode: .alwaysOriginal),
            style: .plain,
            target: self,
            action: #selector(calendarButtonDidTap)
        )
        navigationItem.rightBarButtonItem = calendarBarbutton
    }
    
    func setUI() {
        view.addSubview(backgroundSrcollView)
        backgroundSrcollView.addSubview(titleLabel)
        backgroundSrcollView.addSubview(goalLabel)
        backgroundSrcollView.addSubview(firstMessageLabel)
        backgroundSrcollView.addSubview(deliciousMessageLabel)
        backgroundSrcollView.addSubview(secondMessageLabel)
        backgroundSrcollView.addSubview(thanksLabel)
        backgroundSrcollView.addSubview(habbitImageView)
        backgroundSrcollView.addSubview(carrotHolder)
        backgroundSrcollView.addSubview(carrotButton)
        backgroundSrcollView.addSubview(eatCarrotLabel)
        backgroundSrcollView.addSubview(totalLabel)
        backgroundSrcollView.addSubview(totalImageView)
        backgroundSrcollView.addSubview(recentLabel)
        backgroundSrcollView.sendSubviewToBack(habbitImageView)
        
        backgroundSrcollView.snp.makeConstraints { make in
            make.top.bottom.equalTo(view.safeAreaLayoutGuide)
            make.leading.trailing.equalToSuperview()
        }
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(30)
            make.centerX.equalToSuperview()
        }
        goalLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).inset(-10)
            make.centerX.equalToSuperview()
        }
        habbitImageView.snp.makeConstraints { make in
            make.top.equalTo(goalLabel.snp.bottom).inset(-40)
            make.centerX.equalToSuperview()
            make.width.height.equalTo(385)
        }
        firstMessageLabel.snp.makeConstraints { make in
            make.top.equalTo(goalLabel.snp.bottom).inset(-60)
            make.leading.equalToSuperview().inset(24)
        }
        deliciousMessageLabel.snp.makeConstraints { make in
            make.top.equalTo(goalLabel.snp.bottom).inset(-25)
            make.leading.equalToSuperview().inset(33)
        }
        secondMessageLabel.snp.makeConstraints { make in
            make.top.equalTo(firstMessageLabel.snp.bottom).inset(-41)
            make.leading.equalToSuperview().inset(41)
        }
        thanksLabel.snp.makeConstraints { make in
            make.top.equalTo(goalLabel.snp.bottom).inset(-255)
            make.trailing.equalTo(view.safeAreaLayoutGuide).inset(10)
        }
        carrotHolder.snp.makeConstraints { make in
            make.top.equalTo(habbitImageView.snp.bottom).inset(-60)
            make.centerX.equalToSuperview()
            make.height.equalTo(120)
            make.width.equalTo(120)
        }
        carrotButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalTo(carrotHolder.snp.centerY)
            make.height.equalTo(200)
            make.width.equalTo(200)
        }
        eatCarrotLabel.snp.makeConstraints { make in
            make.top.equalTo(carrotHolder.snp.bottom).inset(-12)
            make.centerX.equalToSuperview()
        }
        totalLabel.snp.makeConstraints { make in
            make.top.equalTo(eatCarrotLabel.snp.bottom).inset(-75)
            make.centerX.equalToSuperview()
        }
        totalImageView.snp.makeConstraints { make in
            make.top.equalTo(totalLabel.snp.bottom).inset(-5)
            make.height.equalTo(140)
            make.width.equalTo(UIScreen.main.bounds.width)
        }
        recentLabel.snp.makeConstraints { make in
            make.top.equalTo(totalImageView.snp.bottom).inset(-70)
            make.centerX.equalToSuperview()
        }
    }
    
//MARK: - function
    @objc func carrotButtonDidTap() {
        deliciousMessageLabel.isHidden = false
        thanksLabel.isHidden = false
        firstMessageLabel.isHidden = true
        secondMessageLabel.isHidden = true
        carrotButton.isHidden = true
        eatCarrotLabel.text = "주기 완료"
        habbitImageView.image = UIImage(named: "habbitFull")
    }
    
    @objc func calendarButtonDidTap() {
        let carrotCalendarVC = CarrotCalendarViewController(goal: goal)
        navigationController?.pushViewController(carrotCalendarVC, animated: true)
        navigationItem.backButtonTitle = ""
    }
}
