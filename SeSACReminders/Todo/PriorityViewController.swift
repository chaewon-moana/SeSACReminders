//
//  PriorityViewController.swift
//  SeSACReminders
//
//  Created by cho on 2/14/24.
//

import UIKit
import SnapKit

class PriorityViewController: BaseViewController {
    
    enum segmentedArray: String, CaseIterable {
        case high = "높음"
        case middel = "보통"
        case low = "낮음"
    }
    
    let segmented: UISegmentedControl = {
        let view = UISegmentedControl(items: ["높음", "보통", "낮음"])
        return view
    }()
    
    var value: ((String) -> Void)?
    
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
        value?(segmentedArray.allCases[segment.selectedSegmentIndex].rawValue)
    }

}


