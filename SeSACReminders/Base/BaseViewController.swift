//
//  BaseViewController.swift
//  SeSACReminders
//
//  Created by cho on 2/14/24.
//

import UIKit

class BaseViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setAddView()
        configureLayout()
        configureAttribute()
    }
    
    func setAddView() { }
    func configureLayout() { }
    func configureAttribute() {
        view.backgroundColor = .black
    }
    
}
