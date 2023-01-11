//
//  HabitsViewController.swift
//  MyHabbits
//
//  Created by Борис Киселев on 05.01.2023.
//

import UIKit

class HabitsViewController: UIViewController {
    
    //MARK: - Subview's
    
    private lazy var habitCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .systemGray6
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(ProgressCollectionViewCell.self, forCellWithReuseIdentifier: "progressCell")
        collectionView.register(HabitCollectionViewCell.self, forCellWithReuseIdentifier: "habitCell")
        
        return collectionView
    }()
    
    //MARK: - LifeCycle
    
    override func viewWillAppear(_ animated: Bool) {
        print(store.habits)
        super.viewWillAppear(animated)
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.tabBarController?.navigationItem.largeTitleDisplayMode = .always
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addTapped))
        navigationItem.rightBarButtonItem?.tintColor = .purple
        
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .white
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = navigationController?.navigationBar.standardAppearance
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemGray5
        title = "Сегодня"
        setupHierarchy()
        setupLayout()
    
    }

    //MARK: - Setup Hierarchy
    
    private func setupHierarchy() {
        view.addSubview(habitCollectionView)
        
    }
    
    //MARK: - Setup Layout
    
    private func setupLayout() {
        habitCollectionView.translatesAutoresizingMaskIntoConstraints = false
        habitCollectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10).isActive = true
        habitCollectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        habitCollectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        habitCollectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
    
    }
    
    //MARK: - Button's Action
    
    @objc func addTapped() {
        let vc = UINavigationController(rootViewController: HabitViewController())
        vc.modalPresentationStyle = .fullScreen
        navigationController?.present(vc, animated: true)
    }

}

extension HabitsViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return section == 0 ? 1 : store.habits.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.section == 0 {
            let cell = habitCollectionView.dequeueReusableCell(withReuseIdentifier: "progressCell", for: indexPath) as! ProgressCollectionViewCell
            cell.layer.cornerRadius = cell.frame.width / 25
            cell.clipsToBounds = true
            
            return cell
        } else {
            let cell = habitCollectionView.dequeueReusableCell(withReuseIdentifier: "habitCell", for: indexPath) as! HabitCollectionViewCell
            cell.layer.cornerRadius = cell.frame.width / 25
            cell.clipsToBounds = true
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let cellWidth:CGFloat = 100
        let spacing: CGFloat = 4
        let columns:CGFloat = ceil(collectionView.bounds.size.width / cellWidth)
        
        let wh = ( habitCollectionView.bounds.size.width - ((columns - 1) * spacing) ) / columns
        let whB = habitCollectionView.bounds.size.height / 4
        
        return indexPath.section == 0 ? CGSize(width: wh, height: wh) : CGSize(width: habitCollectionView.bounds.size.width - 20, height: whB)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {

        return UIEdgeInsets(top: 8, left: 8, bottom: 10, right: 8)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 8
    }
    
    
}
