//
//  SettingViewController.swift
//  SeSACReminders
//
//  Created by cho on 2/14/24.
//

import UIKit
import SnapKit


final class TodoViewController: BaseViewController {

    enum todoList: String, CaseIterable {
        case dueDate = "마감일"
        case tag = "태그"
        case priority = "우선 순위"
        case addImage = "이미지 추가"
    }
    let label = UILabel()
    let tableView = UITableView()
        
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
        navigationItem.title = "새로운 할 일"
        let leftButton = UIBarButtonItem(title: "취소", style: .plain, target: self, action: #selector(leftButtonTapped))
        let rightButton = UIBarButtonItem(title: "추가", style: .plain, target: self, action: #selector(rightButtonTapped))
        navigationItem.leftBarButtonItem = leftButton
        navigationItem.rightBarButtonItem = rightButton
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(TodoTableViewCell.self, forCellReuseIdentifier: "TodoTableViewCell")
        tableView.tableHeaderView = setTableViewHeader()
        tableView.rowHeight = 60
        tableView.separatorStyle = .none
        tableView.backgroundColor = .clear
    }

    
    @objc func leftButtonTapped() {
        dismiss(animated: true)
    }
    @objc func rightButtonTapped() {
        print(#function)
    }
    override func setAddView() {
        view.addSubviews([tableView])
    }
 
    override func configureAttribute() {
        super.configureAttribute()
        label.text = "123123"
        label.textColor = .white
    }
    
    override func configureLayout() {
        tableView.snp.makeConstraints { make in
            make.edges.equalTo(view)
        }
    }
}

extension TodoViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TodoTableViewCell", for: indexPath) as! TodoTableViewCell
        cell.backgroundColor = .clear
        cell.selectionStyle = .none
        cell.mainLabel.text = todoList.allCases[indexPath.row].rawValue
        return cell
    }
    
    func setTableViewHeader() -> UIView {
        let header = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 200))
        
        header.backgroundColor = .black
        header.layer.cornerRadius = 8
        let backView = {
            let view = UIView()
            view.backgroundColor = .gray
            view.layer.cornerRadius = 8
            return view
        }()
        let titleTextField = {
            let view = UITextField()
            view.placeholder = "제목"
            view.textColor = .white
            return view
        }()
        let underLine = {
            let view = UIView()
            view.layer.borderWidth = 1
            view.layer.borderColor = UIColor.lightGray.cgColor
            return view
        }()
        let memoTextView = {
            let view = UITextView()
            view.backgroundColor = .clear
            view.text = "메모"
            return view
        }()
        
        header.addSubview(backView)
        backView.addSubviews([titleTextField,underLine, memoTextView])
        
        backView.snp.makeConstraints { make in
            make.edges.equalTo(header).inset(8)
        }
        titleTextField.snp.makeConstraints { make in
            make.top.equalTo(backView).offset(8)
            make.horizontalEdges.equalTo(backView).inset(8)
            make.height.equalTo(30)
        }
        underLine.snp.makeConstraints { make in
            make.horizontalEdges.equalTo(backView)
            make.top.equalTo(titleTextField.snp.bottom).offset(2)
            make.height.equalTo(1)
        }
        memoTextView.snp.makeConstraints { make in
            make.horizontalEdges.equalTo(backView).inset(8)
            make.top.equalTo(underLine.snp.bottom)
            make.bottom.equalTo(backView.snp.bottom)
        }
        
        return header
  
    }
    
}
