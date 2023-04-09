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
    
    var goalLabel: PaddingLabel = {
        $0.text = "하루에 물 한잔씩 마시기"
        $0.font = UIFont.pretendardRegular(size: 17)
        $0.drawText(in: CGRect(x: 24, y: 24, width: 24, height: 24))
        $0.textColor = UIColor.black
        $0.backgroundColor = UIColor.habbitYellow
        $0.layer.cornerRadius = 13
        $0.layer.masksToBounds = true
        $0.textAlignment = .center
        return $0
    }(PaddingLabel())
    
    let firstMessageLabel: PaddingLabel = {
        $0.text = "오늘 하루도 힘내!"
        $0.font = UIFont.pretendardRegular(size: 17)
        $0.drawText(in: CGRect(x: 24, y: 24, width: 24, height: 24))
        $0.textColor = UIColor.white
        $0.backgroundColor = UIColor.habbitBlack
        $0.layer.cornerRadius = 13
        $0.layer.masksToBounds = true
        $0.textAlignment = .center
        return $0
    }(PaddingLabel())
    
    let secondMessageLabel: PaddingLabel = {
        $0.text = "밥은 먹고 하자~"
        $0.font = UIFont.pretendardRegular(size: 17)
        $0.drawText(in: CGRect(x: 24, y: 24, width: 24, height: 24))
        $0.textColor = UIColor.white
        $0.backgroundColor = UIColor.habbitBlack
        $0.layer.cornerRadius = 13
        $0.layer.masksToBounds = true
        $0.textAlignment = .center
        return $0
    }(PaddingLabel())
    
    let thanksLabel: PaddingLabel = {
        $0.text = "챙겨줘서 고마워"
        $0.font = UIFont.pretendardRegular(size: 17)
        $0.drawText(in: CGRect(x: 24, y: 24, width: 24, height: 24))
        $0.textColor = UIColor.white
        $0.backgroundColor = UIColor.habbitBlack
        $0.layer.cornerRadius = 13
        $0.layer.masksToBounds = true
        $0.textAlignment = .center
        $0.isHidden = true
        return $0
    }(PaddingLabel())
    
    var habbitImageView: UIImageView = {
        $0.image = UIImage(named: "habbit")
        return $0
    }(UIImageView())
    
    let carrotHolder: UIImageView = {
        $0.image = UIImage(named: "carrot_holder")
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
    
//MARK: - Life Cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        self.navigationController?.navigationBar.isHidden = true
        setUI()
        backgroundSrcollView.contentSize = CGSize(width: view.frame.width, height: view.frame.height * 2 - 200)
        
        carrotButton.addTarget(self, action: #selector(carrotButtonDidTap), for: .touchUpInside)
    }
    

    
//MARK: - set UI
    func setUI() {
        view.addSubview(backgroundSrcollView)
        backgroundSrcollView.addSubview(titleLabel)
        backgroundSrcollView.addSubview(goalLabel)
        backgroundSrcollView.addSubview(firstMessageLabel)
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
            make.leading.trailing.equalTo(view.safeAreaLayoutGuide).inset(30)
            make.height.equalTo(350)
        }
        firstMessageLabel.snp.makeConstraints { make in
            make.top.equalTo(goalLabel.snp.bottom).inset(-50)
            make.leading.equalToSuperview().inset(24)
        }
        secondMessageLabel.snp.makeConstraints { make in
            make.top.equalTo(firstMessageLabel.snp.bottom).inset(-21)
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
        thanksLabel.isHidden = false
        secondMessageLabel.isHidden = true
        firstMessageLabel.text = "너무 맛있어!"
        carrotButton.isHidden = true
        eatCarrotLabel.text = "주기 완료"
        habbitImageView.image = UIImage(named: "habbit_full")
    }
}
