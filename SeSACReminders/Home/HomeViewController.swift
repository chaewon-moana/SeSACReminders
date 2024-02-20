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
    func updateData()
}

final class HomeViewController: BaseViewController, HomeVCUpdated {
    
    func updateData() {
        collectionView.reloadData()
    }

    let repo = TodoTableRepository()
    
    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout())
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(HomeCollectionViewCell.self, forCellWithReuseIdentifier: "HomeCollectionViewCell")
        navigationController?.isToolbarHidden = false
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
        print(#function)
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
        view.addSubviews([collectionView])
    }
    
    override func configureLayout() {
        collectionView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    override func configureAttribute() {
        super.configureAttribute()
        collectionView.backgroundColor = .clear
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
