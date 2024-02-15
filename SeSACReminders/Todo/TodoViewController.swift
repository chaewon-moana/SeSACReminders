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
    
    let vcList = [DateViewController(), TagViewController(), PriorityViewController()]
    
    let label = UILabel()
    let tableView = UITableView(frame: .zero, style: .insetGrouped)
        
    let textViewPlaceHolder = "메모"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .primaryBackgroundColor
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
        navigationItem.title = "새로운 할 일"
        let leftButton = UIBarButtonItem(title: "취소", style: .plain, target: self, action: #selector(leftButtonTapped))
        let rightButton = UIBarButtonItem(title: "추가", style: .plain, target: self, action: #selector(rightButtonTapped))
        navigationItem.leftBarButtonItem = leftButton
        navigationItem.rightBarButtonItem = rightButton
        
        tableView.delegate = self
        tableView.dataSource = self
        //tableView.register(TodoTableViewCell.self, forCellReuseIdentifier: "TodoTableViewCell")
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "TodoTableViewCell")
        tableView.sectionFooterHeight = 0
        tableView.tableHeaderView = setTableViewHeader()
        tableView.rowHeight = 50
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
        return 1
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return todoList.allCases.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TodoTableViewCell")!
        cell.textLabel?.text = todoList.allCases[indexPath.section].rawValue
        cell.accessoryType = .disclosureIndicator
        cell.backgroundColor = .secondBackgroundColor
        cell.selectionStyle = .none
        cell.textLabel?.textColor = .white
        cell.textLabel?.font = .systemFont(ofSize: 14)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = vcList[indexPath.row]
        navigationController?.pushViewController(vc, animated: true)
    }
    
    
    func setTableViewHeader() -> UIView {
        let header = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 200))
        
        header.backgroundColor = .primaryBackgroundColor
        header.layer.cornerRadius = 8
        let backView = {
            let view = UIView()
            view.backgroundColor = .secondBackgroundColor
            view.layer.cornerRadius = 8
            return view
        }()
        let titleTextField = {
            let view = UITextField()
            view.attributedPlaceholder = NSAttributedString(string: "제목", attributes: [NSAttributedString.Key.foregroundColor : UIColor.gray])
            view.textColor = .white
            return view
        }()
        let underLine = {
            let view = UIView()
            view.layer.borderWidth = 1
            view.layer.borderColor = UIColor.tableViewCellbackgroundColor.cgColor
            return view
        }()
        let memoTextView = {
            let view = UITextView()
            view.backgroundColor = .clear
            view.text = textViewPlaceHolder
            view.textColor = .gray
            view.font = .systemFont(ofSize: 16)
            view.delegate = self
            return view
        }()
        
        header.addSubview(backView)
        backView.addSubviews([titleTextField,underLine, memoTextView])
        
        backView.snp.makeConstraints { make in
            make.edges.equalTo(header).inset(20)
        }
        titleTextField.snp.makeConstraints { make in
            make.top.equalTo(backView).offset(8)
            make.horizontalEdges.equalTo(backView).inset(12)
            make.height.equalTo(30)
        }
        underLine.snp.makeConstraints { make in
            make.horizontalEdges.equalTo(backView)
            make.top.equalTo(titleTextField.snp.bottom).offset(4)
            make.height.equalTo(1)
        }
        memoTextView.snp.makeConstraints { make in
            make.horizontalEdges.equalTo(backView).inset(8)
            make.top.equalTo(underLine.snp.bottom).offset(2)
            make.bottom.equalTo(backView.snp.bottom)
        }
        
        return header
  
    }
    
}
extension TodoViewController: UITextViewDelegate {

    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.text == textViewPlaceHolder {
            textView.text = nil
            textView.textColor = .white
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = textViewPlaceHolder
            textView.textColor = .gray
        }
    }
}
