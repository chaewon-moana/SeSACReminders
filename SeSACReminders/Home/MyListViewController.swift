//
//  MyListViewController.swift
//  SeSACReminders
//
//  Created by cho on 2/21/24.
//

import UIKit
import SnapKit
import RealmSwift

final class MyListViewController: BaseViewController {

    let tableView = UITableView()
    let customRepo = CustomListRepository()
    var listIndex: Int = 0
    var data: List<TodoTable>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "tableViewCell")
    }
    override func setAddView() {
        view.addSubview(tableView)
    }
    override func configureLayout() {
        tableView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
}

extension MyListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "tableViewCell")!
        let item = data[indexPath.row].name
        cell.textLabel?.text = item
        return cell
    }
    
    
}
