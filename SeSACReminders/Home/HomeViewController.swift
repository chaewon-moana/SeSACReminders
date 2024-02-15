//
//  ViewController.swift
//  SeSACReminders
//
//  Created by cho on 2/14/24.
//

import UIKit
import SnapKit

final class HomeViewController: BaseViewController {

    enum homeCellList: String, CaseIterable {
        case today = "오늘"
        case expected = "예정"
        case all = "전체"
        case flag = "깃발 표시"
        case done = "완료됨"
    }
    
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
        let TodoAddButton = UIBarButtonItem(title: "새로운 할 일", style: .plain, target: self, action: #selector(todoAddButtonTapped))
        let listAddButton = UIBarButtonItem(title: "목록 추가", style: .plain, target: self, action: #selector(listAddButtonTapped))
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
        toolbarItems = [TodoAddButton, flexibleSpace, listAddButton]
    }
    
    @objc func listAddButtonTapped() {
        print(#function)
    }
    
    @objc func todoAddButtonTapped() {
        let vc = UINavigationController(rootViewController: TodoViewController())
        present(vc, animated: true)
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
        
        //cell.backgroundColor = .primaryBackgroundColor
        cell.categoryLabel.text = homeCellList.allCases[indexPath.item].rawValue
        cell.countLabel.text = "0"
        
        return cell
    }
    
    
}
