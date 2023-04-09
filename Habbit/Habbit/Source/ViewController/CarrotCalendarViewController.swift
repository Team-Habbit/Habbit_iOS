//
//  CarrotCalendarViewController.swift
//  Habbit
//
//  Created by 김상혁 on 2023/04/09.
//

import UIKit
import SnapKit
import FSCalendar

final class CarrotCalendarViewController: UIViewController {
    
    private lazy var monthHeaderLabel: UILabel = {
        let label = UILabel()
        label.font = .pretendardRegular(size: 20)
        label.textColor = .label
        return label
    }()
    
    private lazy var prevMonthButton: UIButton = {
        let button = UIButton(type: .system)
        let image = UIImage(systemName:"arrowtriangle.left.fill")?
            .resized(to: CGSize(width: 16, height: 16))?
            .withTintColor(UIColor.habbitBlack, renderingMode: .alwaysOriginal)
        button.setImage(image, for: .normal)
        button.addTarget(self, action: #selector(prevButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var nextMonthButton: UIButton = {
        let button = UIButton(type: .system)
        let image = UIImage(systemName:"arrowtriangle.right.fill")?
            .resized(to: CGSize(width: 16, height: 16))?
            .withTintColor(UIColor.habbitBlack, renderingMode: .alwaysOriginal)
        
        button.setImage(image, for: .normal)
        button.addTarget(self, action: #selector(nextButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var calendar: FSCalendar = {
        let calendar = FSCalendar()
        calendar.delegate = self
        calendar.dataSource = self
        calendar.locale = Locale(identifier: "ko_KR")
        calendar.allowsMultipleSelection = true
        calendar.appearance.headerTitleColor = .clear
        calendar.appearance.headerMinimumDissolvedAlpha = 0
        calendar.appearance.todayColor = .clear
        calendar.appearance.titleTodayColor = .label
        calendar.appearance.todaySelectionColor = .clear
        calendar.appearance.selectionColor = .habbitYellow
        calendar.appearance.weekdayTextColor = .systemBackground
        calendar.appearance.weekdayFont = UIFont.pretendardBold(size: 14)
        calendar.calendarWeekdayView.backgroundColor = UIColor.habbitBlack
        calendar.calendarWeekdayView.layer.cornerRadius = 10
        calendar.placeholderType = .none
        return calendar
    }()
    
//    private let startDate: Date
//    private let endDate: Date
    private let userTasks: [DailyTask]
    
    init(goal: Goal) {
        print(goal)
        self.userTasks = goal.aimedPeriod
//        self.startDate = goal.startDate
//        self.endDate = goal.endDate
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        layoutUI()
    }
}

// MARK: - Selector Methods

private extension CarrotCalendarViewController {
    @objc private func prevButtonTapped() {
        let currentMonth = calendar.currentPage
        guard let previousMonth = Calendar.current.date(byAdding: .month, value: -1, to: currentMonth) else { return }
        calendar.setCurrentPage(previousMonth, animated: true)
    }
    
    @objc private func nextButtonTapped() {
        let currentMonth = calendar.currentPage
        guard let nextMonth = Calendar.current.date(byAdding: .month, value: 1, to: currentMonth) else { return }
        calendar.setCurrentPage(nextMonth, animated: true)
    }
}

// MARK: - Calendar Delegate

extension CarrotCalendarViewController: FSCalendarDelegate {
    
    func calendarCurrentPageDidChange(_ calendar: FSCalendar) {
        configureCalenderHeaderText()
    }
    
    func calendar(_ calendar: FSCalendar, shouldSelect date: Date, at monthPosition: FSCalendarMonthPosition) -> Bool {
        let today = Calendar.current.startOfDay(for: Date())
        return date >= today
    }
    
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        
    }
    
    func calendar(_ calendar: FSCalendar, didDeselect date: Date, at monthPosition: FSCalendarMonthPosition) {
        
    }
}

// MARK: - Calendar DataSource

extension CarrotCalendarViewController: FSCalendarDataSource {
    
}

// MARK: - Calendar DelegateAppearance

extension CarrotCalendarViewController: FSCalendarDelegateAppearance {
    func calendar(_ calendar: FSCalendar, imageFor date: Date) -> UIImage? {
        let userPeriodDates = userTasks.map { $0.date }
        if !userPeriodDates.contains(date) {
            return nil
        }
        
        let targetTask = userTasks.first {
            $0.date == date
        }
        
        guard let targetTask = targetTask else { return nil }
        let image = targetTask.isCompleted ? UIImage(named: "carrot")?.resized(to: CGSize(width: 38, height: 38)): UIImage(systemName: "pencil")?.resized(to: CGSize(width: 38, height: 38))
        
        return image
    }
    
    func calendar(_ calendar: FSCalendar, appearance: FSCalendarAppearance, imageOffsetFor date: Date) -> CGPoint {
        return CGPoint(x: 0, y: 4)
    }
    
    func calendar(_ calendar: FSCalendar, appearance: FSCalendarAppearance, titleOffsetFor date: Date) -> CGPoint {
        if UIScreen.main.bounds.height <= 736 {
            return CGPoint(x: .zero, y: -14)
        } else {
            return CGPoint(x: .zero, y: -10)
        }
    }
    
//    func calendar(_ calendar: FSCalendar, subtitleFor date: Date) -> String? {
//        if date.formattedString == Date().formattedString {
//            return "오늘"
//        }
//        return nil
//    }
    
    func calendar(_ calendar: FSCalendar, appearance: FSCalendarAppearance, titleDefaultColorFor date: Date) -> UIColor? {
        let userPeriodDates = userTasks.map { $0.date }
        
        if !userPeriodDates.contains(date) {
            return .secondaryLabel
        } else {
            return .label
        }
    }
    
    func calendar(_ calendar: FSCalendar, appearance: FSCalendarAppearance, titleSelectionColorFor date: Date) -> UIColor? {
        return .label
    }
    
    func calendar(_ calendar: FSCalendar, appearance: FSCalendarAppearance, subtitleDefaultColorFor date: Date) -> UIColor? {
        return .label
    }
    
    func calendar(_ calendar: FSCalendar, appearance: FSCalendarAppearance, subtitleSelectionColorFor date: Date) -> UIColor? {
        return .label
    }
    
    func calendar(_ calendar: FSCalendar, appearance: FSCalendarAppearance, fillSelectionColorFor date: Date) -> UIColor? {
        return .habbitYellow
    }
}

// MARK: - Supporting Methods

private extension CarrotCalendarViewController {
    private func configureCalenderHeaderText() {
        let formatter = DateFormatter()
        formatter.dateFormat = "M월"
        let currentPage = calendar.currentPage
        monthHeaderLabel.text = formatter.string(from: currentPage)
    }
}

// MARK: - UI Configurations

private extension CarrotCalendarViewController {
    func configureUI() {
        view.backgroundColor = .systemBackground
        configureCalenderHeaderText()
    }
    
    func layoutUI() {
        view.addSubview(monthHeaderLabel)
        view.addSubview(prevMonthButton)
        view.addSubview(nextMonthButton)
        view.addSubview(calendar)
        
        monthHeaderLabel.snp.makeConstraints { make in
            make.bottom.equalTo(calendar.calendarWeekdayView.snp.top).offset(-22)
            make.centerX.equalToSuperview()
        }
        
        nextMonthButton.snp.makeConstraints { make in
            make.leading.equalTo(monthHeaderLabel.snp.trailing).offset(18)
            make.centerY.equalTo(monthHeaderLabel)
        }
        
        prevMonthButton.snp.makeConstraints { make in
            make.trailing.equalTo(monthHeaderLabel.snp.leading).offset(-18)
            make.centerY.equalTo(monthHeaderLabel)
        }
        
        calendar.snp.makeConstraints { make in
            make.leading.equalTo(view.safeAreaLayoutGuide.snp.leading).offset(18)
            make.trailing.equalTo(view.safeAreaLayoutGuide.snp.trailing).offset(-18)
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(130)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-100)
        }
    }
}

