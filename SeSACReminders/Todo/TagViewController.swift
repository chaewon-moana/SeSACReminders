//
//  TagViewController.swift
//  SeSACReminders
//
//  Created by cho on 2/14/24.
//

import UIKit
import SnapKit

final class TagViewController: BaseViewController {

    let tagTextField = UITextField()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .primaryBackgroundColor
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.post(name: Notification.Name("TagValueReceived"), object: nil, userInfo: ["tag": tagTextField.text!])
    }
    override func setAddView() {
        view.addSubviews([tagTextField])
    }
    
    override func configureLayout() {
        tagTextField.snp.makeConstraints { make in
            make.horizontalEdges.equalTo(view).inset(12)
            make.top.equalTo(view.safeAreaLayoutGuide).offset(20)
            make.height.equalTo(40)
        }
    }
    
    override func configureAttribute() {
        super.configureAttribute()
        tagTextField.backgroundColor = .secondBackgroundColor
        tagTextField.layer.cornerRadius = 8
        tagTextField.placeholder = "태그를 입력해주세요"
        tagTextField.textColor = .white
        
    }
}
