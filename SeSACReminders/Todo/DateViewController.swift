//
//  DateViewController.swift
//  SeSACReminders
//
//  Created by cho on 2/14/24.
//

import UIKit
import SnapKit

final class DateViewController: BaseViewController {
    
    let datePicker = UIDatePicker()
    var dateValue: Date?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .primaryBackgroundColor
        datePicker.addTarget(self, action: #selector(datePickerValueChanged), for: .valueChanged)
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.post(name: NSNotification.Name("DateValueReceived"), object: nil, userInfo: ["datePickerValue": dateValue!])
    }
    @objc func datePickerValueChanged(_ sender: UIDatePicker) {
        dateValue = sender.date
        print(sender.date)
    }
    override func setAddView() {
        view.addSubview(datePicker)
    }
    
    override func configureLayout() {
        datePicker.snp.makeConstraints { make in
            make.edges.equalTo(view).inset(40)
        }
    }
    
    override func configureAttribute() {
        datePicker.datePickerMode = .dateAndTime
        datePicker.preferredDatePickerStyle = .inline
    }
}

