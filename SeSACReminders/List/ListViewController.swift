//
//  ListViewController.swift
//  SeSACReminders
//
//  Created by cho on 2/18/24.
//

import UIKit
import SnapKit

final class ListViewController: BaseViewController {

    let tableView = UITableView()
    let repo = TodoTableRepository()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .primaryBackgroundColor
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "system")
        
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
        tableView.backgroundColor = .blue
    }

}

extension ListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return repo.fetchAllRecordCount()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "system")!
        cell.textLabel?.text = "testtest"
        return cell
    }
    
    
}
