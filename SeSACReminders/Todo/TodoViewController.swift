//
//  SettingViewController.swift
//  SeSACReminders
//
//  Created by cho on 2/14/24.
//

import UIKit
import SnapKit
import Toast

final class TodoViewController: BaseViewController {

    enum todoList: String, CaseIterable {
        case dueDate = "마감일"
        case tag = "태그"
        case priority = "우선 순위"
        case addImage = "이미지 추가"
        case list = "목록 추가"
    }
    
    var delegate: HomeVCUpdated?
    
    let label = UILabel()
    let tableView = UITableView(frame: .zero, style: .insetGrouped)
    let photoImageView = UIImageView()
    
    let textViewPlaceHolder = "메모"
    var dateValue: String = "" {
        didSet {
            tableView.reloadData()
        }
    }
    var currentData: TodoTable = TodoTable(name: "", memo: nil, dueDate: nil, tag: nil, priority: nil)
    let repo = TodoTableRepository()
    lazy var rightButton = UIBarButtonItem(title: "추가", style: .plain, target: self, action: #selector(rightButtonTapped))
    
    var textViewText = ""
    var textFieldText = ""
    var selectedList: Int = 0
    let homeVC = HomeViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .primaryBackgroundColor
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
        navigationItem.title = "새로운 할 일"
        let leftButton = UIBarButtonItem(title: "취소", style: .plain, target: self, action: #selector(leftButtonTapped))
 
        navigationItem.leftBarButtonItem = leftButton
        rightButton.isEnabled = false
        navigationItem.rightBarButtonItem = rightButton
        
        tableView.delegate = self
        tableView.dataSource = self
        //TODO: SystemCell말고 다르게 할 순 없나,,,,?
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "TodoTableViewCell")
        //tableView.register(TodoTableViewCell.self, forCellReuseIdentifier: "TodoTableViewCell")
        tableView.sectionFooterHeight = 0
        tableView.tableHeaderView = setTableViewHeader()
        tableView.separatorStyle = .none
        tableView.backgroundColor = .clear
        NotificationCenter.default.addObserver(self, selector: #selector(datePickerReceived), name: Notification.Name("DateValueReceived"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(tagReceived), name: Notification.Name("TagValueReceived"), object: nil)
       // NotificationCenter.default.addObserver(self, selector: #selector(listNameReceived), name: Notification.Name("ListNameReceived"), object: nil)
        
        photoImageView.isHidden = true
        
    }

    @objc func tagReceived(notification: NSNotification) {
        if let value = notification.userInfo?["tag"] as? String {
            currentData.tag = value
        }
    }
    
    @objc func datePickerReceived(notification: NSNotification) {
        if let value = notification.userInfo?["datePickerValue"] as? Date {
            let myDateFormatter = DateFormatter()
            myDateFormatter.dateFormat = "yyyy년 MM월 dd일 HH:mm"
            myDateFormatter.locale = Locale(identifier:"ko_KR")
            let convertStr = myDateFormatter.string(from: value)
            dateValue = convertStr
            currentData.dueDate = myDateFormatter.date(from: convertStr)
        }
    }
    
    @objc func leftButtonTapped() {
        homeVC.collectionView.reloadData()
        dismiss(animated: true)
    }
    
    @objc func rightButtonTapped() {
        
        
        currentData.name = textFieldText
        currentData.memo = textViewText
        delegate?.updateData(data: currentData, selectedList: selectedList)
        dismiss(animated: true)
    }
    
    override func setAddView() {
        view.addSubviews([tableView])
    }
 
    override func configureAttribute() {
        super.configureAttribute()
        label.textColor = .white
    }
    
    override func configureLayout() {
        tableView.snp.makeConstraints { make in
//            make.top.horizontalEdges.equalTo(view)
//            make.height.equalTo(520)
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
//        photoImageView.snp.makeConstraints { make in
//            make.top.equalTo(tableView.snp.bottom)
//            make.centerX.equalTo(view)
//            make.size.equalTo(100)
//        }
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
        if indexPath.section == 0 {
            let label = UILabel()
            label.text = dateValue
            label.font = .systemFont(ofSize: 12)
            label.textAlignment = .right
            label.textColor = .gray
            cell.contentView.addSubview(label)
            label.snp.makeConstraints { make in
                make.height.equalTo(12)
                make.width.equalTo(200)
                make.centerY.equalTo(cell.contentView)
                make.trailing.equalTo(cell.contentView).inset(20)
            }
        } 
        cell.accessoryType = .disclosureIndicator
        cell.backgroundColor = .secondBackgroundColor
        cell.selectionStyle = .none
        cell.textLabel?.textColor = .white
        cell.textLabel?.font = .systemFont(ofSize: 14)
        
        //TODO: 이미지에 따라서 isHidden과 아닌 걸로 나누고,,이미지가 등록이 되어있따면 뜨도록,,
        
        if indexPath.section == 3 {
         
                let backView = UIView()
                cell.contentView.addSubview(backView)
                backView.addSubview(photoImageView)
                backView.snp.makeConstraints { make in
                    make.size.equalTo(100)
                    make.trailing.equalTo(cell.contentView.snp.trailing).inset(20)
                    make.top.equalTo(cell.contentView.snp.top).offset(8)
                }
                backView.backgroundColor = .clear
                photoImageView.snp.makeConstraints { make in
                    make.edges.equalTo(backView)
                }
                //photoImageView.image = UIImage(systemName: "circle")
            }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 3 {
            return photoImageView.isHidden == false ? 120 : UITableView.automaticDimension
        } else {
            return UITableView.automaticDimension
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.section {
        case 0 :
            let vc = DateViewController()
            navigationController?.pushViewController(vc, animated: true)
        case 1 :
            let vc = TagViewController()
            navigationController?.pushViewController(vc, animated: true)
        case 2:
            let vc = PriorityViewController()
            vc.value = { value in
                self.currentData.priority = value
            }
            navigationController?.pushViewController(vc, animated: true)
        case 3:
            let vc = UIImagePickerController()
            vc.delegate = self
            vc.allowsEditing = true
            present(vc, animated: true)
        case 4: //TODO: 목록선택뷰만들어서 챱챱
            let vc = SelectListViewController()
            vc.value = { value in
                self.selectedList = value
                print(value, "선택된 리스트")
            }
            navigationController?.pushViewController(vc, animated: true)
        default:
            print("TodoVC switch문 에러")
        }
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
            view.delegate = self
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
        backView.addSubviews([titleTextField, underLine, memoTextView])
        
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

extension TodoViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        print(#function)
        
        //originalImage를 넣으면 편집을 해도 original이 들어감,,
        if let pickedImage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
            photoImageView.image = pickedImage
            photoImageView.isHidden = false
            tableView.reloadData()
        }
        dismiss(animated: true)
    }
}

extension TodoViewController: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField.text! != "" {
            textFieldText = textField.text!
        }
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField.text == "" {
            rightButton.isEnabled = false
        } else {
            rightButton.isEnabled = true
        }
        return true
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
        } else {
            textViewText = textView.text
        }
    }
}


