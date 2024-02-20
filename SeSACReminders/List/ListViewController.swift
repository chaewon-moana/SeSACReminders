//
//  ListViewController.swift
//  SeSACReminders
//
//  Created by cho on 2/18/24.
//

import UIKit
import SnapKit
import RealmSwift

final class ListViewController: BaseViewController {

    var delegate: HomeVCUpdated?
    
    let tableView = UITableView()
    let repo = TodoTableRepository()
    //lazy var list = repo.fetchAllRecord()
    var tmpList: Results<TodoTable>!
    let dateFormatter = DateFormatter()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .primaryBackgroundColor
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(ListTableViewCell.self, forCellReuseIdentifier: "ListTableViewCell")
        tableView.rowHeight = 80
        
        let backButton = UIBarButtonItem(title: "뒤로가기", style: .plain, target: self, action: #selector(backButtonTapped))
        navigationItem.leftBarButtonItem = backButton

//        let first = UIAction(title: "제목 오름차순") { _ in
//            self.list = self.repo.sortedTitleAscending(ascending: true)
//            self.tableView.reloadData()
//        }
        
//        let second = UIAction(title: "두번째 확인") { _ in
//            print("확확인")
//        }
//        
//        let rightFilterButton = UIBarButtonItem(image: UIImage(systemName: "list.bullet.circle"), style: .plain, target: self, action: #selector(rightFilterButton))
//        rightFilterButton.menu = UIMenu(children: [first, second])
//        navigationItem.rightBarButtonItem = rightFilterButton
    }
    
    @objc func rightFilterButton() {
        print("오른버튼 눌림")
    }
    @objc func backButtonTapped() {
        navigationController?.popViewController(animated: true)
        delegate?.updateData()
    }
    override func setAddView() {
        view.addSubview(tableView)
    }
    
    override func configureLayout() {
        tableView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    override func configureAttribute() {
        tableView.backgroundColor = .primaryBackgroundColor
    }


}

extension ListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tmpList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ListTableViewCell", for: indexPath) as! ListTableViewCell
        let item = tmpList[indexPath.row]
        cell.checkBoxImage.image = item.done ? UIImage(systemName: "circle.fill") : UIImage(systemName: "circle")
        cell.titleLabel.text = item.title
        cell.memoLabel.text = item.memo
        dateFormatter.dateFormat = "yyyy년 MM월 dd일 hh시 mm분"
        if let date = item.dueDate {
            cell.dueDate.text = dateFormatter.string(from: date)
        } else {
            cell.dueDate.text = ""
        }
        cell.tagLabel.text = item.tag
        cell.photoImageView.image = loadImageFromDocument(fileName: "\(item.id)")
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        repo.updateDoneAttribute(index: indexPath.row)
        tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let delete = UIContextualAction(style: .normal, title: "삭제") { _,_,_  in
            print("삭제삭제")
            self.repo.deleteItem(self.tmpList[indexPath.row])
            self.tableView.reloadData()
        }
        delete.backgroundColor = .systemRed
        return UISwipeActionsConfiguration(actions:[delete])
    }
    
    
}
