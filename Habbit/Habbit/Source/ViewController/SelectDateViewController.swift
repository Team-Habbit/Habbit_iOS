//
//  SelectDateViewController.swift
//  Habbit
//
//  Created by 김상혁 on 2023/04/09.
//

import UIKit
import SnapKit
import FSCalendar

final class SelectDateViewController: UIViewController {
    private let indicateImage: UIImageView = {
        $0.image = UIImage(named: "startThree")
        return $0
    }(UIImageView())
    
    private lazy var enterPeriodLabel: UILabel = {
        let label = UILabel()
        label.text = "기간을 알려주세요 :)"
        label.font = .cafe24Ssurround(size: 24)
        return label
    }()
    
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
        button.addTarget(self, action: #selector(prevMonthButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var nextMonthButton: UIButton = {
        let button = UIButton(type: .system)
        let image = UIImage(systemName:"arrowtriangle.right.fill")?
            .resized(to: CGSize(width: 16, height: 16))?
            .withTintColor(UIColor.habbitBlack, renderingMode: .alwaysOriginal)
        
        button.setImage(image, for: .normal)
        button.addTarget(self, action: #selector(nextMonthButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var startDateLabel: FixedSizePaddingLabel = {
        let label = FixedSizePaddingLabel(padding: .custom(top: 8, left: 16, bottom: 8, right: 16))
        label.backgroundColor = .systemGray4
        dateformatter.dateFormat = "yyyy.MM.dd"
        label.text = dateformatter.string(from: Date())
        label.textAlignment = .center
        label.clipsToBounds = true
        label.layer.cornerRadius = 14
        label.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        return label
    }()
    
    private lazy var endDateLabel: FixedSizePaddingLabel = {
        let label = FixedSizePaddingLabel(padding: .custom(top: 8, left: 16, bottom: 8, right: 16))
        label.backgroundColor = .systemGray4
        dateformatter.dateFormat = "yyyy.MM.dd"
        label.text = dateformatter.string(from: Date())
        label.textAlignment = .center
        label.clipsToBounds = true
        label.layer.cornerRadius = 14
        label.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        return label
    }()
    
    private lazy var tildeLabel: UILabel = {
        let label = UILabel()
        label.text = "~"
        label.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        return label
    }()
    
    private lazy var dateLabelStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [startDateLabel, tildeLabel, endDateLabel])
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.distribution = .fillProportionally
        stackView.spacing = 10
        return stackView
    }()
    
    private lazy var calendar: FSCalendar = {
        let calendar = FSCalendar()
        calendar.delegate = self
        calendar.dataSource = self
        calendar.locale = Locale(identifier: "ko_KR")
        calendar.allowsMultipleSelection = true
        calendar.appearance.headerTitleColor = .clear
        calendar.appearance.headerMinimumDissolvedAlpha = 0
        calendar.appearance.subtitleOffset = CGPoint(x: 0, y: 4)
        calendar.appearance.todayColor = .lightGray
        calendar.appearance.todaySelectionColor = .clear
        calendar.appearance.selectionColor = .habbitYellow
        calendar.appearance.weekdayTextColor = .systemBackground
        calendar.appearance.weekdayFont = UIFont.pretendardBold(size: 14)
        calendar.calendarWeekdayView.backgroundColor = UIColor.habbitBlack
        calendar.calendarWeekdayView.layer.cornerRadius = 10
        calendar.placeholderType = .none
        return calendar
    }()
    
    private lazy var nextButton: UIButton = {
        let button = UIButton()
        var attributedString = NSMutableAttributedString(string: "완료")
        attributedString.addAttribute(.font, value: UIFont.pretendardBold(size: 16), range: NSRange(location: 0, length: attributedString.length))
        attributedString.addAttribute(.foregroundColor, value: UIColor.white, range: NSRange(location: 0, length: attributedString.length))
        button.setAttributedTitle(attributedString, for: .normal)
        button.layer.cornerRadius = 16
        button.backgroundColor = UIColor.gray
        button.isEnabled = false
        
        button.addAction(UIAction(handler: { [weak self] _ in
            guard let targetString = self?.targetString,
                  let categoryClicked = self?.categoryClicked,
                  let selectedDates = self?.selectedDates else { return }
            let aimedPriod = selectedDates.compactMap { DailyTask(date: $0, isCompleted: false) }
            let userGoal = Goal(name: targetString, category: categoryClicked, aimedPeriod: aimedPriod)
            let nextViewController = HomeViewController(goal: userGoal)
            self?.navigationController?.setViewControllers([nextViewController], animated: true)
        }), for: .touchUpInside)
        return button
    }()
    
    private var dateformatter = DateFormatter()
    
    private var selectedDates: [Date]? {
        willSet {
            if newValue?.count ?? .zero > 1 {
                nextButton.isEnabled = true
                nextButton.backgroundColor = .habbitBlack
            } else {
                nextButton.isEnabled = false
                nextButton.backgroundColor = .gray
            }
        }
    }
    
    private var startDate: Date? {
        willSet {
            dateformatter.dateFormat = "yyyy.MM.dd"
            if let newValue = newValue {
                startDateLabel.text = dateformatter.string(from: newValue)
            } else {
                startDateLabel.text = nil
            }
        }
    }
    
    private var endDate: Date? {
        willSet {
            dateformatter.dateFormat = "yyyy.MM.dd"
            if let newValue = newValue {
                endDateLabel.text = dateformatter.string(from: newValue)
            } else {
                endDateLabel.text = nil
            }
        }
    }
    
    var targetString: String?
    var categoryClicked: GoalCategory?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        layoutUI()
    }
}

// MARK: - Selector Methods

private extension SelectDateViewController {
    @objc private func prevMonthButtonTapped() {
        let currentMonth = calendar.currentPage
        guard let previousMonth = Calendar.current.date(byAdding: .month, value: -1, to: currentMonth) else { return }
        calendar.setCurrentPage(previousMonth, animated: true)
    }
    
    @objc private func nextMonthButtonTapped() {
        let currentMonth = calendar.currentPage
        guard let nextMonth = Calendar.current.date(byAdding: .month, value: 1, to: currentMonth) else { return }
        calendar.setCurrentPage(nextMonth, animated: true)
    }
}

// MARK: - Calendar Delegate

extension SelectDateViewController: FSCalendarDelegate {
    
    func calendarCurrentPageDidChange(_ calendar: FSCalendar) {
        configureCalenderHeaderText()
    }
    
    func calendar(_ calendar: FSCalendar, shouldSelect date: Date, at monthPosition: FSCalendarMonthPosition) -> Bool {
        let today = Calendar.current.startOfDay(for: Date())
        return date >= today
    }
    
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        if startDate == nil && endDate == nil {
            startDate = date
            selectedDates = [startDate ?? Date()]
            endDate = nil
            return
        }
        
        if startDate != nil && endDate == nil {
            if date <= startDate! {
                calendar.deselect(startDate ?? Date())
                startDate = date
                selectedDates = [startDate ?? Date()]
            } else {
                endDate = date
                selectedDates = datesRange(from: startDate ?? Date(), to: endDate ?? Date())
                selectedDates?.forEach { calendar.select($0) }
            }
            return
        }
        
        if startDate != nil && endDate != nil {
            clearSelectedDates(in: calendar)
        }
    }
    
    func calendar(_ calendar: FSCalendar, didDeselect date: Date, at monthPosition: FSCalendarMonthPosition) {
        if startDate != nil && endDate == nil {
            startDate = nil
        }
        
        if startDate != nil && endDate != nil {
            clearSelectedDates(in: calendar)
        }
    }
}

// MARK: - Calendar DataSource

extension SelectDateViewController: FSCalendarDataSource {
    
}

// MARK: - Calendar DelegateAppearance

extension SelectDateViewController: FSCalendarDelegateAppearance {
    func calendar(_ calendar: FSCalendar, subtitleFor date: Date) -> String? {
        if date.formattedString == Date().formattedString {
            return "오늘"
        }
        return nil
    }
    
    func calendar(_ calendar: FSCalendar, appearance: FSCalendarAppearance, titleDefaultColorFor date: Date) -> UIColor? {
        
        let today = Calendar.current.startOfDay(for: Date())
        if date.formattedString < today.formattedString {
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

private extension SelectDateViewController {
    private func configureCalenderHeaderText() {
        let formatter = DateFormatter()
        formatter.dateFormat = "M월"
        let currentPage = calendar.currentPage
        monthHeaderLabel.text = formatter.string(from: currentPage)
    }
    
    private func clearSelectedDates(in calendar: FSCalendar) {
        calendar.selectedDates.forEach { calendar.deselect($0) }
        startDate = nil
        endDate = nil
        selectedDates = []
    }
    
    private func datesRange(from startDate: Date, to endDate: Date) -> [Date] {
        guard startDate <= endDate else { return [] }
        
        var currentDate = startDate
        var dates = [currentDate]
        
        while currentDate < endDate {
            guard let nextDate = Calendar.current.date(byAdding: .day, value: 1, to: currentDate) else { break }
            dates.append(nextDate)
            currentDate = nextDate
        }
        return dates
    }
}


// MARK: - UI Configurations

private extension SelectDateViewController {
    func configureUI() {
        view.backgroundColor = .systemBackground
        configureCalenderHeaderText()
    }
    
    func layoutUI() {
        view.addSubview(indicateImage)
        view.addSubview(enterPeriodLabel)
        view.addSubview(prevMonthButton)
        view.addSubview(nextMonthButton)
        view.addSubview(dateLabelStackView)
        view.addSubview(monthHeaderLabel)
        view.addSubview(calendar)
        view.addSubview(nextButton)
        
        indicateImage.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).inset(5)
            make.centerX.equalToSuperview()
            make.width.equalTo(170)
            make.height.equalTo(40)
        }
        enterPeriodLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalTo(monthHeaderLabel.snp.top).offset(-44)
        }
        nextMonthButton.snp.makeConstraints { make in
            make.leading.equalTo(monthHeaderLabel.snp.trailing).offset(18)
            make.centerY.equalTo(monthHeaderLabel)
        }
        
        prevMonthButton.snp.makeConstraints { make in
            make.trailing.equalTo(monthHeaderLabel.snp.leading).offset(-18)
            make.centerY.equalTo(monthHeaderLabel)
        }
        
        dateLabelStackView.snp.makeConstraints { make in
            make.leading.trailing.equalTo(calendar)
            make.bottom.equalTo(calendar.calendarWeekdayView.snp.top).offset(-22)
        }
        
        monthHeaderLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalTo(dateLabelStackView.snp.top).offset(-28)
        }
        
        calendar.snp.makeConstraints { make in
            make.leading.equalTo(view.safeAreaLayoutGuide.snp.leading).offset(46)
            make.trailing.equalTo(view.safeAreaLayoutGuide.snp.trailing).offset(-46)
            make.height.equalTo(400)
            make.bottom.equalTo(nextButton.snp.top).offset(-48)
        }
        
        nextButton.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide).inset(15)
            make.leading.trailing.equalToSuperview().inset(20)
            make.height.equalTo(60)
        }
    }
}
