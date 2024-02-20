//
//  CustomListViewController.swift
//  SeSACReminders
//
//  Created by cho on 2/20/24.
//

import UIKit
import SnapKit
import RealmSwift

class CustomListViewController: BaseViewController {

    let listNameTextField = UITextField()
    let listIconImagerView = UIImageView()
    let realm = try! Realm()
    let homeVC = HomeViewController()
    
    var delegate: CustomListUpdated?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemGray6
        
        let saveButton = UIBarButtonItem(title: "저장", style: .plain, target: self, action: #selector(saveButtonTapped))
        navigationItem.rightBarButtonItem = saveButton
    }
    
    @objc func saveButtonTapped() {
        do {
            try realm.write {
                realm.add(CustomList(name: listNameTextField.text!, regDate: Date(), icon: "star", color: "red"))
            }
        } catch {
            print("customListVC 에러에러")
        }
        delegate?.reloadTable()
        dismiss(animated: true)
    }

    
    override func setAddView() {
        view.addSubviews([listNameTextField, listIconImagerView])
    }
    
    override func configureLayout() {
        listIconImagerView.snp.makeConstraints { make in
            make.size.equalTo(100)
            make.centerX.equalTo(view.safeAreaLayoutGuide)
            make.top.equalTo(view.safeAreaLayoutGuide).offset(20)
        }
        
        listNameTextField.snp.makeConstraints { make in
            make.height.equalTo(50)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(40)
            make.top.equalTo(listIconImagerView.snp.bottom).offset(20)
        }  
    }
    
    override func configureAttribute() {
        listNameTextField.placeholder = "목록 이름"
        listNameTextField.layer.borderWidth = 1
        listNameTextField.layer.borderColor = UIColor.gray.cgColor
        
        listIconImagerView.image = UIImage(systemName: "list.bullet.circle")
    }
}

