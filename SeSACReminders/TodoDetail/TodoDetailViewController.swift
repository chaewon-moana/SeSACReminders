//
//  TodoDetailViewController.swift
//  SeSACReminders
//
//  Created by cho on 2/19/24.
//

import UIKit
import SnapKit

class TodoDetailViewController: BaseViewController {

    let titleLabel = UILabel()
    let memoLabel = UILabel()
    let dueDateLabel = UILabel()
    let tagLabel = UILabel()
    let priorityLabel = UILabel()
    let photoView = UIImageView()
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func setAddView() {
        view.addSubviews([titleLabel, memoLabel, dueDateLabel, tagLabel, priorityLabel, photoView])
    }
    
    override func configureLayout() {
        
    }
    
    override func configureAttribute() {
        
        
    }

}
