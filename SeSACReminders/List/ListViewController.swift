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

    let tableView = UITableView()
    let repo = TodoTableRepository()
    lazy var list = repo.fetchAllRecord()
    let tapGesture = UITapGestureRecognizer(target: ListViewController.self, action: #selector(checkBoxImageTapped))
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .primaryBackgroundColor
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(ListTableViewCell.self, forCellReuseIdentifier: "ListTableViewCell")
        tableView.rowHeight = 80
        
        
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

    
    @objc func checkBoxImageTapped() {
        print("이미지눌려땅!")
    }

}

extension ListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return repo.fetchAllRecordCount()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ListTableViewCell", for: indexPath) as! ListTableViewCell

        cell.checkBoxImage.image = list[indexPath.row].done ? UIImage(systemName: "circle.fill") : UIImage(systemName: "circle")
        cell.titleLabel.text = list[indexPath.row].title
        cell.memoLabel.text = list[indexPath.row].memo
        cell.dueDate.text = list[indexPath.row].dueDate
        cell.tagLabel.text = list[indexPath.row].tag
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        repo.updateDoneAttribute(index: indexPath.row)
        tableView.reloadData()
    }
    
    
}
