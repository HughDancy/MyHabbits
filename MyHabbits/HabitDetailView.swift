//
//  HabitDetailView.swift
//  MyHabbits
//
//  Created by Борис Киселев on 12.01.2023.
//

import UIKit

class HabitDetailView: UIViewController {
    
    var detailIndex = 0
    
    // MARK: - Subview's
    private lazy var activityLabel: UILabel = {
        let label = UILabel()
        label.text = "АКТИВНОСТЬ"
        label.font = UIFont(name: "HelveticaNeuw", size: 11)
        label.textColor = .systemGray
        
        return label
    }()
    
    private lazy var datesTable: UITableView = {
        let table = UITableView(frame: .zero, style: .plain)
        table.delegate = self
        table.dataSource = self
        table.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        table.backgroundColor = .systemGray6
        
        return table
    }()
    
    // MARK: - Lifecycle
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupNavigationBar()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    // MARK: - Setup View
    private func setupView() {
        view.backgroundColor = .systemGray6
        setupHierarchy()
        setupLayout()
    }

    // MARK: - Setup Hierarchy
    private func setupHierarchy() {
        view.addSubview(activityLabel)
        view.addSubview(datesTable)
    }
    
    private func setupLayout() {
        
        activityLabel.translatesAutoresizingMaskIntoConstraints = false
        activityLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 30).isActive = true
        activityLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20).isActive = true
        
        datesTable.translatesAutoresizingMaskIntoConstraints = false
        datesTable.topAnchor.constraint(equalTo: activityLabel.bottomAnchor, constant: 10).isActive = true
        datesTable.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        datesTable.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        datesTable.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
    }

    // MARK: - Setup NavigationBar
    private func setupNavigationBar() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Назад", style: .plain, target: self, action: #selector(getBack))
        navigationItem.leftBarButtonItem?.tintColor = .purple

        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Править", style: .plain, target: self, action: #selector(change))
        navigationItem.rightBarButtonItem?.tintColor = .purple

        let label = UILabel()
        label.backgroundColor = .clear
        label.font = UIFont(name: "HelveticaNeue-Bold", size: 15)
        label.numberOfLines = 2
        label.textAlignment = .center
        label.text = store.habits[detailIndex].name
        navigationItem.titleView = label
        tabBarController?.tabBar.isHidden = false
    }

    // MARK: - Button's Action's
    @objc func getBack() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc func change() {
        let vc = HabitViewController()
        vc.backToRootDelegate = self
        vc.index = detailIndex
        let nc = UINavigationController(rootViewController: vc)
        nc.modalPresentationStyle = .fullScreen
        navigationController?.present(nc, animated: true)
    }
}

// MARK: - TableView Extension
extension HabitDetailView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return store.dates.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        var content = cell.defaultContentConfiguration()
        
        content.text = store.trackDateString(forIndex: indexPath.row)
        cell.contentConfiguration = content
        cell.selectionStyle = .none
        
        if store.habit(store.habits[detailIndex], isTrackedIn: store.dates[indexPath.row]) {
            cell.accessoryType = .checkmark
            cell.tintColor = .purple
        }
        
        return cell
    }
}

extension HabitDetailView: BackToRoot {
    func backToRoot() {
        navigationController?.popToRootViewController(animated: true)
    }
}
