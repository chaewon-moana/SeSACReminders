//
//  CustomListTableViewCell.swift
//  SeSACReminders
//
//  Created by cho on 2/20/24.
//

import UIKit
import SnapKit

class CustomListTableViewCell: BaseTableViewCell {

    let iconImageView = UIImageView()
    let listLabel = UILabel()
    
    override func setAddView() {
        contentView.addSubviews([iconImageView, listLabel])
    }
    
    override func configureLayout() {
        iconImageView.snp.makeConstraints { make in
            make.size.equalTo(32)
            make.centerY.equalTo(contentView)
            make.leading.equalTo(contentView).offset(12)
        }
        listLabel.snp.makeConstraints { make in
            make.leading.equalTo(iconImageView.snp.trailing).offset(12)
            make.centerY.equalTo(contentView)
        }
    }
    
    override func configureAttribute() {
        iconImageView.image = UIImage(systemName: "star")
        listLabel.text = "목록츄가츄가"
        listLabel.font = .systemFont(ofSize: 14)
    }

}
