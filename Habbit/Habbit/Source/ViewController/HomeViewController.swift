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
        $0.image = UIImage(named: "habbit")
        return $0
    }(UIImageView())
    
    var carrotButton: UIButton = {
        $0.setImage(UIImage(named: "carrot"), for: .normal)
        $0.setImage(UIImage(named: "finishCarrot"), for: .selected)
        return $0
    }(UIButton())
    
    let eatCarrotLabel: UILabel = {
        $0.text = "당근 주기"
        $0.font = UIFont.cafe24Ssurround(size: 17)
        $0.textColor = UIColor.black
        $0.textAlignment = .center
        return $0
    }(UILabel())
    
    let vectorImage: UIImageView = {
        $0.image = UIImage(named: "vector")
        return $0
    }(UIImageView())
    
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
    
    lazy var recentCarrotButton: UIButton = {
        changeAttributedString("", $0)
        $0.layer.cornerRadius = 13
        $0.backgroundColor = UIColor.habbitBlack
        return $0
    }(UIButton())
    
    private var goal: Goal
    private var timer: Timer?
    
    init(goal: Goal) {
        self.goal = goal
        goalLabel.text = goal.name
        super.init(nibName: nil, bundle: nil)
        print(goal.userName)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        timer?.invalidate()
    }
    
//MARK: - Life Cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setUI()
        setUpBarButton()
        setName()
        backgroundSrcollView.contentSize = CGSize(width: view.frame.width, height: view.frame.height + (view.frame.height / 2))
        carrotButton.addTarget(self, action: #selector(carrotButtonDidTap), for: .touchUpInside)
        scheduleDailyViewUpdate()
    }
    
//MARK: - set UI
    func setUpBarButton() {
        let calendarBarbutton = UIBarButtonItem(
            image: UIImage(named: "calendar")?.withRenderingMode(.alwaysOriginal),
            style: .plain,
            target: self,
            action: #selector(calendarButtonDidTap)
        )
        navigationItem.rightBarButtonItem = calendarBarbutton
    }
    
    func setName() {
        changeAttributedString("\(goal.userName)님은 당근을 3번 먹었어요", recentCarrotButton)
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
        backgroundSrcollView.addSubview(carrotButton)
        backgroundSrcollView.addSubview(eatCarrotLabel)
        backgroundSrcollView.addSubview(vectorImage)
        backgroundSrcollView.addSubview(totalLabel)
        backgroundSrcollView.addSubview(totalImageView)
        backgroundSrcollView.addSubview(recentLabel)
        backgroundSrcollView.addSubview(recentCarrotButton)
        backgroundSrcollView.sendSubviewToBack(habbitImageView)
        
        backgroundSrcollView.snp.makeConstraints { make in
            make.top.bottom.equalTo(view.safeAreaLayoutGuide)
            make.leading.trailing.equalToSuperview()
        }
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(10)
            make.centerX.equalToSuperview()
        }
        goalLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).inset(-10)
            make.centerX.equalToSuperview()
        }
        habbitImageView.snp.makeConstraints { make in
            make.top.equalTo(goalLabel.snp.bottom).inset(-25)
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
        carrotButton.snp.makeConstraints { make in
            make.top.equalTo(habbitImageView.snp.bottom).inset(-35)
            make.centerX.equalToSuperview()
            make.height.equalTo(116)
            make.width.equalTo(120)
        }
        eatCarrotLabel.snp.makeConstraints { make in
            make.top.equalTo(carrotButton.snp.bottom).inset(-12)
            make.centerX.equalToSuperview()
        }
        vectorImage.snp.makeConstraints { make in
            make.top.equalTo(eatCarrotLabel.snp.bottom).inset(-66)
            make.centerX.equalToSuperview()
            make.height.width.equalTo(17)
        }
        totalLabel.snp.makeConstraints { make in
            make.top.equalTo(vectorImage.snp.bottom).inset(-35)
            make.centerX.equalToSuperview()
        }
        totalImageView.snp.makeConstraints { make in
            make.top.equalTo(totalLabel.snp.bottom).inset(-5)
            make.height.equalTo(140)
            make.width.equalTo(UIScreen.main.bounds.width)
        }
        recentLabel.snp.makeConstraints { make in
            make.top.equalTo(totalImageView.snp.bottom).inset(-100)
            make.centerX.equalToSuperview()
        }
        recentCarrotButton.snp.makeConstraints { make in
            make.top.equalTo(recentLabel.snp.bottom).inset(-20)
            make.centerX.equalToSuperview()
            make.leading.trailing.equalTo(view.safeAreaLayoutGuide).inset(33)
            make.height.equalTo(67)
        }
    }
    
//MARK: - function
    func changeAttributedString(_ text: String,_ button: UIButton) {
        button.setTitle(text, for: .normal)
        button.titleLabel?.font = UIFont.pretendardBold(size: 18)
    }
    
    @objc func carrotButtonDidTap() {
        if carrotButton.isSelected == false {
            deliciousMessageLabel.isHidden = false
            thanksLabel.isHidden = false
            firstMessageLabel.isHidden = true
            secondMessageLabel.isHidden = true
            carrotButton.isSelected = true
            eatCarrotLabel.text = "주기 완료"
            habbitImageView.image = UIImage(named: "habbitFull")
            goal.complete(today: Date())
        } else {
            let vc = FinishViewController()
            self.present(vc, animated: true)
        }
    }
    
    @objc func calendarButtonDidTap() {
        let carrotCalendarVC = CarrotCalendarViewController(goal: goal)
        navigationController?.pushViewController(carrotCalendarVC, animated: true)
        navigationItem.backButtonTitle = ""
    }
    
    private func scheduleDailyViewUpdate() {
        var calendar = Calendar.current
        calendar.timeZone = TimeZone(identifier: "Asia/Seoul")!
        
        let now = Date()
        let tomorrow = calendar.date(byAdding: .day, value: 1, to: now)!
        let tomorrowMidnight = calendar.startOfDay(for: tomorrow)
        
        let interval = tomorrowMidnight.timeIntervalSince(now)
        
        timer = Timer.scheduledTimer(withTimeInterval: interval, repeats: false) { [weak self] _ in
            self?.updateViewForNewDay()
            self?.scheduleDailyViewUpdate()
        }
    }
    
    private func updateViewForNewDay() {
        deliciousMessageLabel.isHidden = true
        thanksLabel.isHidden = true
        firstMessageLabel.isHidden = false
        secondMessageLabel.isHidden = false
        carrotButton.isSelected = false
        eatCarrotLabel.text = "당근 주기"
        habbitImageView.image = UIImage(named: "habbit")
    }
}
