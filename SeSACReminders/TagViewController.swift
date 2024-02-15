//
//  TagViewController.swift
//  SeSACReminders
//
//  Created by cho on 2/14/24.
//

import UIKit
import SnapKit

class TagViewController: BaseViewController {

    let tagTextField = UITextField()
    
    override func viewDidLoad() {
        super.viewDidLoad()

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
        tagTextField.backgroundColor = .blue
        
    }
}
