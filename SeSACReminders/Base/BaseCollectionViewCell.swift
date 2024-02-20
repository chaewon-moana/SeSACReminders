//
//  BaseCollectionViewCell.swift
//  SeSACReminders
//
//  Created by cho on 2/20/24.
//

import UIKit

class BaseCollectionViewCell: UICollectionViewCell {

    override init(frame: CGRect) {
        super.init(frame: frame)
        setAddView()
        configureLayout()
        configureAttribute()
        setViewDidLoad()
    }
    func setViewDidLoad() { }
    func setAddView() {  }
    func configureLayout() { }
    func configureAttribute() { }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
