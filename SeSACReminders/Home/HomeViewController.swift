//
//  ViewController.swift
//  SeSACReminders
//
//  Created by cho on 2/14/24.
//

import UIKit
import SnapKit

protocol HomeVCUpdated {
    func updateData()
}

final class HomeViewController: BaseViewController, HomeVCUpdated {
    func updateData() {
        todoListCount[2] = repo.fetchAllRecordCount()
        todoListCount[4] = repo.fetchDoneRecordCount()
        collectionView.reloadData()
    }

    let repo = TodoTableRepository()
    
    enum homeCellList: String, CaseIterable {
        case today = "오늘"
        case expected = "예정"
        case all = "전체"
        case flag = "깃발 표시"
        case done = "완료됨"
    }
    
    var cellIcons = ["13.square", "calendar", "tray.fill", "flag.fill", "checkmark"]
    lazy var todoListCount = [0,0,repo.fetchAllRecordCount(),0,repo.fetchDoneRecordCount()]
    var valueChanged: Int = 0
    
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
        
        let first = UIAction(title: "제목 오름차순") { _ in
        //
            //self.repository.sortedTitleAscending(ascending: true)
        }
        
        let second = UIAction(title: "두번째 확인") { _ in
            print("확확인")
        }
        
        let rightFilterButton = UIBarButtonItem(image: UIImage(systemName: "list.bullet.circle"), style: .plain, target: self, action: #selector(rightFilterButton))
        //누르면 바로 Menu가 뜨도록 함. 그런데 왜 자동완성이 안됨,,
        //UIBarButtonItem은 꾹 눌러야 뜸, 누르면 바로 뜨도록 하고 싶을 땐 어떻게 해야하지
        rightFilterButton.menu = UIMenu(children: [first, second])
        navigationItem.rightBarButtonItem = rightFilterButton
        let TodoAddButton = UIBarButtonItem(title: "새로운 할 일", style: .plain, target: self, action: #selector(todoAddButtonTapped))
        let listAddButton = UIBarButtonItem(title: "목록 추가", style: .plain, target: self, action: #selector(listAddButtonTapped))
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
        toolbarItems = [TodoAddButton, flexibleSpace, listAddButton]
    }
    
    @objc func rightFilterButton() {
        
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
        
        cell.imageView.image = UIImage(systemName: cellIcons[indexPath.item])
        cell.categoryLabel.text = homeCellList.allCases[indexPath.item].rawValue
//        cell.countLabel.text = indexPath.item == 4 ? "\(todoListCount[indexPath.item]) / \(repo.fetchAllRecordCount())" : "\(todoListCount[indexPath.item])"
        cell.countLabel.text = "\(todoListCount[indexPath.item])"
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.item == 2 {
            let vc = ListViewController()
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    
}
