//
//  HomeCollectionViewCell.swift
//  SeSACReminders
//
//  Created by cho on 2/14/24.
//

import UIKit
import SnapKit

final class HomeCollectionViewCell: UICollectionViewCell {
    
    let imageView = UIImageView()
    let categoryLabel = UILabel()
    let countLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setAddView()
        configureLayout()
        configureAttribute()
    }
    
    private func setAddView() {
        contentView.addSubviews([imageView, categoryLabel, countLabel])
    }
    
    private func configureLayout() {
        imageView.snp.makeConstraints { make in
            make.size.equalTo(30)
            make.leading.equalTo(contentView).offset(12)
            make.top.equalTo(contentView).offset(12)
        }
        
        categoryLabel.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp.bottom).offset(8)
            make.leading.equalTo(contentView).offset(16)
            make.height.equalTo(24)
        }
        
        countLabel.snp.makeConstraints { make in
            make.top.equalTo(contentView).offset(12)
            make.trailing.equalTo(contentView).inset(20)
            make.height.equalTo(32)
        }
    }
    
    private func configureAttribute() {
        contentView.backgroundColor = .primaryBackgroundColor
        contentView.layer.cornerRadius = 8
        imageView.image = UIImage(systemName: "person")
        categoryLabel.textColor = .lightGray
        categoryLabel.font = .systemFont(ofSize: 15)
        countLabel.textColor = .white
        countLabel.font = .boldSystemFont(ofSize: 28)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
