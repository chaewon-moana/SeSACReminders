//
//  SelectListViewController.swift
//  SeSACReminders
//
//  Created by cho on 2/21/24.
//

import UIKit

class SelectListViewController: BaseViewController {

    let customRepo = CustomListRepository()
    
    lazy var segmented: UISegmentedControl = {
        let view = UISegmentedControl(items: customRepo.fetchListName())
        return view
    }()
    
    var value: ((Int) -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        segmented.addTarget(self, action: #selector(didChangeValue(segment:)), for: .valueChanged)
    }
    
    override func setAddView() {
        view.addSubview(segmented)
    }
    
    override func configureLayout() {
        segmented.snp.makeConstraints { make in
            make.horizontalEdges.equalTo(view).inset(20)
            make.height.equalTo(40)
            make.top.equalTo(view.safeAreaLayoutGuide).offset(30)
        }
    }
    
    override func configureAttribute() {
        segmented.selectedSegmentIndex = 0
        view.backgroundColor = .primaryBackgroundColor
    }
    
    @objc func didChangeValue(segment: UISegmentedControl) {
        value?(segment.selectedSegmentIndex)
    }
}
