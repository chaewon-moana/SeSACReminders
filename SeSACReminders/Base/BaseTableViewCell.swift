//
//  BaseTableViewCell.swift
//  SeSACReminders
//
//  Created by cho on 2/20/24.
//

import UIKit

class BaseTableViewCell: UITableViewCell {

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
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
