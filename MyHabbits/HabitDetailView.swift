//
//  HabitDetailView.swift
//  MyHabbits
//
//  Created by Борис Киселев on 12.01.2023.
//

import UIKit

class HabitDetailView: UIViewController {
    
    //MARK: - Subview's
    
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
    
    
    //MARK: - Lifecycle
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let appereance = UINavigationBarAppearance()
        appereance.backgroundColor = .white
        navigationController?.navigationBar.standardAppearance = appereance
        navigationController?.navigationBar.scrollEdgeAppearance = navigationController?.navigationBar.standardAppearance
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Назад", style: .plain, target: self, action: #selector(getBack))
        navigationItem.leftBarButtonItem?.tintColor = .purple
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Править", style: .plain, target: self, action: #selector(change))
        navigationItem.rightBarButtonItem?.tintColor = .purple
        
        title = store.habits[rightIndex].name
        tabBarController?.tabBar.isHidden = false
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemGray6
        setupHierarchy()
        setupLayout()
        
        // Do any additional setup after loading the view.
    }
    
    //MARK: - Setup Hierarchy
    
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
    //MARK: - Button's Action's
    
    @objc func getBack() {
        dismiss(animated: true)
    }
    
    @objc func change() {
        
    }
    
}

//MARK: - TableView Extension

extension HabitDetailView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return store.dates.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        var content = cell.defaultContentConfiguration()
        let index = indexPath.row
        content.text = store.trackDateString(forIndex: index)
        cell.contentConfiguration = content
        
        cell.selectionStyle = .none
        
        if store.habit(store.habits[index], isTrackedIn: store.dates[index]) {
            cell.accessoryType = .checkmark
            cell.tintColor = .purple
        }
        
        return cell
    }
    
    
}
