//
//  HabitsViewController.swift
//  MyHabbits
//
//  Created by Борис Киселев on 05.01.2023.
//

import UIKit

class HabitsViewController: UIViewController {
    // MARK: - Subview's
    lazy var habitCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .systemGray6
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(ProgressCollectionViewCell.self, forCellWithReuseIdentifier: "progressCell")
        collectionView.register(HabitCollectionViewCell.self, forCellWithReuseIdentifier: "habitCell")
        collectionView.showsVerticalScrollIndicator = false
        return collectionView
    }()

    // MARK: - LifeCycle
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.setupNavigationBar()
        habitCollectionView.reloadData()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupView()
    }

    // MARK: - Setup Navigation
    private func setupNavigationBar() {
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

    // MARK: - Setup View
    private func setupView() {
        view.backgroundColor = .systemGray6
        title = "Сегодня"
        setupHierarchy()
        setupLayout()
    }

    // MARK: - Setup Hierarchy
    private func setupHierarchy() {
        view.addSubview(habitCollectionView)
    }

    // MARK: - Setup Layout
    private func setupLayout() {
        habitCollectionView.translatesAutoresizingMaskIntoConstraints = false
        habitCollectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10).isActive = true
        habitCollectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        habitCollectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        habitCollectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
    }

    // MARK: - Button's Action
    @objc func addTapped() {
        let vc = UINavigationController(rootViewController: HabitViewController())
        vc.modalPresentationStyle = .fullScreen
        navigationController?.present(vc, animated: true)
    }

    @objc func buttonTap(_ sender: UIButton, index: Int) {
        print(index)
        if store.habits[index].isAlreadyTakenToday == false {
            store.track(store.habits[index])
            sender.setImage(UIImage(systemName: "checkmark.circle.fill"), for: .normal)
        }
    }
}

// MARK: - CollectionView extension
extension HabitsViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return section == 0 ? 1 : store.habits.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.section == 0 {
            guard let cell = habitCollectionView.dequeueReusableCell(withReuseIdentifier: "progressCell", for: indexPath) as? ProgressCollectionViewCell else { return UICollectionViewCell() }
            cell.setupData()
            cell.layer.cornerRadius = cell.frame.width / 50
            cell.clipsToBounds = true

            return cell
        } else {
            guard let cell = habitCollectionView.dequeueReusableCell(withReuseIdentifier: "habitCell", for: indexPath) as? HabitCollectionViewCell else { return UICollectionViewCell() }
            cell.layer.cornerRadius = cell.frame.width / 40
            cell.cellIndex = indexPath.row
            cell.setupCell(with: indexPath.row)

            cell.delegate = self
            cell.clipsToBounds = true
            cell.layoutIfNeeded()
            return cell
        }
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        if UIScreen.main.bounds.size.height < 1180 {
            return indexPath.section == 0 ? CGSize(width: habitCollectionView.bounds.size.width - 20, height: 80) : CGSize(width: habitCollectionView.bounds.width - 20, height: habitCollectionView.frame.height / 3.5)
        } else {
            return indexPath.section == 0 ? CGSize(width: habitCollectionView.bounds.size.width - 20, height: 80) : CGSize(width: habitCollectionView.bounds.width - 20, height: habitCollectionView.frame.height / 6)
        }
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
         UIEdgeInsets(top: 8, left: 8, bottom: 10, right: 8)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
         8
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.section != 0 && !store.habits.isEmpty {
            goToHabit(habbitIndex: indexPath.row)
        }
    }
}

extension HabitsViewController: MyTableViewCellDelegate {
    func didTapButton() {
        habitCollectionView.reloadData()
    }
}

extension HabitsViewController {
    private func goToHabit(habbitIndex: Int) {
        let vc =  HabitDetailView()
        vc.modalPresentationStyle = .fullScreen
        vc.hidesBottomBarWhenPushed = false
        vc.detailIndex = habbitIndex
        navigationController?.pushViewController(vc, animated: true)
    }
}
