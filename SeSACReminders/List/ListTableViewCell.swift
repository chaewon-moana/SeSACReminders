//
//  ListTableViewCell.swift
//  SeSACReminders
//
//  Created by cho on 2/18/24.
//

import UIKit
import SnapKit

final class ListTableViewCell: UITableViewCell {

    let checkBoxImage = UIImageView()
    let titleLabel = UILabel()
    let memoLabel = UILabel()
    let stackView = UIStackView()
    let dueDate = UILabel()
    let tagLabel = UILabel()
    let photoImageView = UIImageView()
    //TODO: priority 별 3개로 그려서 checkBoxImage아래에 넣기
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setAddView()
        configureLayout()
        configureAttribute()
        contentView.backgroundColor = .primaryBackgroundColor
    }
    
    private func setAddView() {
        contentView.addSubviews([checkBoxImage, titleLabel, memoLabel, stackView, photoImageView])
        stackView.addSubviews([dueDate, tagLabel])
    }
    
    private func configureLayout() {
        checkBoxImage.snp.makeConstraints { make in
            make.size.equalTo(24)
            make.leading.equalTo(contentView.snp.leading).offset(12)
            make.top.equalTo(contentView.snp.top).offset(8)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.leading.equalTo(checkBoxImage.snp.trailing).offset(8)
            make.top.equalTo(contentView.snp.top).offset(8)
            make.height.equalTo(20)
        }
        
        memoLabel.snp.makeConstraints { make in
            make.leading.equalTo(checkBoxImage.snp.trailing).offset(8)
            make.top.equalTo(titleLabel.snp.bottom).offset(4)
            make.height.equalTo(16)
        }
        
        stackView.snp.makeConstraints { make in
            make.leading.equalTo(checkBoxImage.snp.trailing).offset(8)
            make.height.equalTo(16)
            make.top.equalTo(memoLabel.snp.bottom).offset(4)
            make.width.equalTo(100)
        }
        dueDate.snp.makeConstraints { make in
            make.leading.equalTo(stackView.snp.leading)
            make.centerY.equalToSuperview()
        }
        tagLabel.snp.makeConstraints { make in
            make.leading.equalTo(dueDate.snp.trailing).offset(4)
            make.centerY.equalToSuperview()
        }
        photoImageView.snp.makeConstraints { make in
            make.size.equalTo(50)
            make.trailing.equalTo(contentView).inset(10)
            make.centerY.equalTo(contentView)
        }
    }
    
    private func configureAttribute() {
        stackView.axis = .horizontal
        stackView.alignment = .leading
        stackView.spacing = 4
        
        checkBoxImage.image = UIImage(systemName: "circle")
        checkBoxImage.isUserInteractionEnabled = true
        
        memoLabel.text = "메모메모메모"
        memoLabel.font = .systemFont(ofSize: 14)
        memoLabel.textColor = .gray
        
        dueDate.textColor = .gray
        dueDate.font = .systemFont(ofSize: 13)
        
        tagLabel.textColor = .blue
        tagLabel.font = .systemFont(ofSize: 13)
        
        photoImageView.image = UIImage(systemName: "star")
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
}
