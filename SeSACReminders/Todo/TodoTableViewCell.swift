//
//  TodoTableViewCell.swift
//  SeSACReminders
//
//  Created by cho on 2/14/24.
//

import UIKit
import SnapKit

final class TodoTableViewCell: UITableViewCell {
    
    let backView = UIView()
    let mainLabel = UILabel()
    let chevronImageView = {
        let image = UIImageView()
        image.image = UIImage(systemName: "chevron.right")
        image.tintColor = .lightGray
        return image
    }()
    let subLabel = UILabel()
    let photoImageView = UIImageView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setAddView()
        configureLayout()
        configureAttribute()
    }
    
    func setAddView() {
        contentView.addSubview(backView)
        backView.addSubviews([mainLabel, chevronImageView, subLabel, photoImageView])
    }
    
    func configureLayout() {
        backView.snp.makeConstraints { make in
            make.edges.equalTo(contentView).inset(8)
        }
        mainLabel.snp.makeConstraints { make in
            make.centerY.equalTo(backView)
            make.leading.equalTo(backView).offset(16)
            make.height.equalTo(24)
        }
        chevronImageView.snp.makeConstraints { make in
            make.height.equalTo(20)
            make.width.equalTo(14)
            make.centerY.equalTo(backView)
            make.trailing.equalTo(backView).inset(16)
        }
        subLabel.snp.makeConstraints { make in
            make.height.equalTo(18)
            make.bottom.equalTo(mainLabel.snp.bottom)
            make.leading.equalTo(mainLabel.snp.trailing).offset(4)
        }
        photoImageView.snp.makeConstraints { make in
            make.trailing.equalTo(subLabel.snp.leading).inset(12)
            make.centerY.equalTo(contentView)
            make.size.equalTo(100)
            
        }
    }
    
    func configureAttribute() {
        backView.layer.cornerRadius = 8
        backView.backgroundColor = .gray
        mainLabel.textColor = .white
        photoImageView.image = UIImage(systemName: "pencil")
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
}
