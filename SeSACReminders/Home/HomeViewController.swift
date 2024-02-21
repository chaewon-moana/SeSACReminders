//
//  ViewController.swift
//  SeSACReminders
//
//  Created by cho on 2/14/24.
//

import UIKit
import SnapKit
import RealmSwift

protocol HomeVCUpdated {
    func updateData(data: TodoTable, selectedList: Int)
}

protocol CustomListUpdated {
    func reloadTable()
}

final class HomeViewController: BaseViewController, HomeVCUpdated, CustomListUpdated {
    
    func updateData(data: TodoTable, selectedList: Int) {
        
//        
//        do {
//            try realm.write {
//                //realm.add(CustomList(name: listNameTextField.text!, regDate: Date(), icon: "star", color: "red"))
//                //data.todo.append(todo)
//                realm.add(CustomList(name: listNameTextField.text!, regDate: Date(), icon: "", color: ""))
//            }
//            dismiss(animated: true)
//        } catch {
//            print("customListVC 에러에러")
//        }
        
        let listData = realm.objects(CustomList.self)[selectedList]
        do {
            try realm.write {
                listData.todo.append(data)
            }
        } catch {
            print("에러")
        }
        //repo.createRecord(data)
        collectionView.reloadData()
        tableView.reloadData()
    }
    
    func reloadTable() {
        tableView.reloadData()
    }

    let repo = TodoTableRepository()
    let customRepo = CustomListRepository()
    let realm = try! Realm()
    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout())
    let tableView = UITableView(frame: .zero, style: .insetGrouped)
    let customListLabel = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(realm.configuration.fileURL)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(HomeCollectionViewCell.self, forCellWithReuseIdentifier: "HomeCollectionViewCell")
        navigationController?.isToolbarHidden = false
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(CustomListTableViewCell.self, forCellReuseIdentifier: "CustomListTableViewCell")
        tableView.rowHeight = 50
        
        //Dummy
//        let folderList = ["개인", "업무", "동아리"]
//        for i in folderList {
//            do {
//                try realm.write {
//                    realm.add(CustomList(name: i, regDate: Date(), icon: "icon\(i)", color: "asdf"))
//                }
//            } catch {
//                print(error)
//            }
//        }
        
        
        //let image = UIImage(systemName: "plus.circle.fill")
       //TODO: button에 이미지랑 text랑 같이 넣기
       // let TodoAddButton = UIBarButtonItem(title: "새로운 할 일", image: image, target: self, action: #selector(todoAddButtonTapped))

        
//        let rightFilterButton = UIBarButtonItem(image: UIImage(systemName: "list.bullet.circle"), style: .plain, target: self, action: #selector(rightFilterButton))
        //누르면 바로 Menu가 뜨도록 함. 그런데 왜 자동완성이 안됨,,
        //UIBarButtonItem은 꾹 눌러야 뜸, 누르면 바로 뜨도록 하고 싶을 땐 어떻게 해야하지
      //  rightFilterButton.menu = UIMenu(children: [first, second])
        let TodoAddButton = UIBarButtonItem(title: "새로운 할 일", style: .plain, target: self, action: #selector(todoAddButtonTapped))
        let listAddButton = UIBarButtonItem(title: "목록 추가", style: .plain, target: self, action: #selector(listAddButtonTapped))
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
        toolbarItems = [TodoAddButton, flexibleSpace, listAddButton]
    }

    @objc func listAddButtonTapped() {
        let vc = CustomListViewController()
        let nav = UINavigationController(rootViewController: vc)
        vc.delegate = self
        present(nav, animated: true)
    }
    
    @objc func todoAddButtonTapped() {
        let vc = TodoViewController()
        vc.delegate = self
        let nav = UINavigationController(rootViewController: vc)
        present(nav, animated: true)
    }
    
    static func collectionViewLayout() -> UICollectionViewFlowLayout {
        let layout = UICollectionViewFlowLayout()
        
        let spacing: CGFloat = 8
        let cellWidth = UIScreen.main.bounds.width - spacing
        layout.itemSize = CGSize(width: cellWidth / 2.3, height: 90)
        layout.sectionInset = UIEdgeInsets(top: 8, left: 20, bottom: 8, right: 20)
        layout.scrollDirection = .vertical
        
        return layout
    }
 
    override func setAddView() {
        view.addSubviews([collectionView, tableView, customListLabel])
    }
    
    override func configureLayout() {
        collectionView.snp.makeConstraints { make in
            make.horizontalEdges.top.equalTo(view.safeAreaLayoutGuide)
            make.height.equalTo(300)
        }
        
        customListLabel.snp.makeConstraints { make in
            make.top.equalTo(collectionView.snp.bottom).offset(16)
            make.leading.equalTo(collectionView.snp.leading).offset(32)
            make.height.equalTo(20)
        }
        tableView.snp.makeConstraints { make in
            make.top.equalTo(customListLabel.snp.bottom)
            make.horizontalEdges.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    override func configureAttribute() {
        super.configureAttribute()
        collectionView.backgroundColor = .clear
        customListLabel.text = "나의 목록"
        customListLabel.textColor = .white
        customListLabel.font = .boldSystemFont(ofSize: 20)
        
    }
}
extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return customRepo.fetchAllRecords().count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CustomListTableViewCell", for: indexPath) as! CustomListTableViewCell
        let item = customRepo.fetchAllRecords()[indexPath.row]
        
        cell.listLabel.text = item.name
        cell.iconImageView.image = UIImage(systemName: item.icon)
        cell.countLabel.text = "\(item.todo.count)"
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = MyListViewController()
        let tmp = customRepo.fetchAllRecords()[indexPath.row].name
        vc.data = customRepo.fetchListRecord(name: tmp).first?.todo
        navigationController?.pushViewController(vc, animated: true)
    }
    
}
extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HomeCollectionViewCell", for: indexPath) as! HomeCollectionViewCell
        
        cell.imageView.image = UIImage(systemName: homeCellList.allCases[indexPath.item].cellIcons)
        cell.categoryLabel.text = homeCellList.allCases[indexPath.item].rawValue
//        cell.countLabel.text = indexPath.item == 4 ? "\(todoListCount[indexPath.item]) / \(repo.fetchAllRecordCount())" : "\(todoListCount[indexPath.item])"
        cell.countLabel.text = "\(homeCellList.allCases[indexPath.item].todoListCount)"
        if indexPath.item == 0 {
            cell.countLabel.text = "\(todayTodo().count)"
        } else if indexPath.item == 1 {
            cell.countLabel.text = "\(expectedTodo().count)"
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        //TODO: 오늘, 예정, 깃발 등 필터링해서 목록을 넘겨줘서 나올 수 있도록 만들기,,,,
        
        let homeCellName = homeCellList.allCases[indexPath.item]
        
        let vc = ListViewController()
        vc.delegate = self
        
        switch homeCellName {
        case .today:
            vc.tmpList = todayTodo()
        case .expected:
            vc.tmpList = expectedTodo()
        case .all:
            vc.tmpList = repo.fetchAllRecord()
        case .flag:
            print("123123")
        case .done:
            print("123123")
        }
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func todayTodo() -> Results<TodoTable> {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy년 MM월 dd일"
        
        let start = Calendar.current.startOfDay(for: Date())
        let end: Date = Calendar.current.date(byAdding: .day, value: 1, to: start) ?? Date()
        let predicate = NSPredicate(format: "dueDate >= %@ && dueDate < %@", start as NSDate, end as NSDate)
        
        let list = repo.fetchAllRecord().filter(predicate)
        print(list.count)
        return list
    }
    
    func expectedTodo() -> Results<TodoTable> {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy년 MM월 dd일"
        
        let start = Calendar.current.startOfDay(for: Date())
        let end: Date = Calendar.current.date(byAdding: .day, value: 1, to: start) ?? Date()
        let predicate = NSPredicate(format: "dueDate > %@", end as NSDate)
        
        let list = repo.fetchAllRecord().filter(predicate)
        return list
    }
    
}
