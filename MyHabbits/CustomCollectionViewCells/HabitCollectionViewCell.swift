//
//  HabitCollectionViewCell.swift
//  MyHabbits
//
//  Created by Борис Киселев on 10.01.2023.
//

import UIKit

class HabitCollectionViewCell: UICollectionViewCell {
    
    let reuseId = "habitCell"
    
    //MARK: - Subview's
    
    private lazy var habitLabel: UILabel = {
       let label = UILabel()
        label.text = store.habits[rightIndex].name
        label.textColor = store.habits[rightIndex].color
        label.font = UIFont(name: "HelveticaNeue", size: HabitFontSize.headlineSize.rawValue)
        
        return label
    }()
    
    private lazy var timeLabel: UILabel = {
       let label = UILabel()
        label.font = UIFont(name: "HelveticaNeue", size: HabitFontSize.casualTextSize.rawValue)
        label.textColor = .lightGray
        label.text = "Каждый день в \(formatter(with: store.habits[rightIndex].date))"
        
        return label
    }()
    
    private lazy var counterLabel: UILabel = {
       let label = UILabel()
        label.font = UIFont(name: "HelveticaNeue", size: HabitFontSize.casualTextSize.rawValue)
        label.textColor = .lightGray
        label.text = "Счетчик: \(String(store.habits[rightIndex].trackDates.count))"
      
        return label
    }()
    
    //TO-DO TOMMOROW - BUTTONS FRAME IS CHANGE, IMAGE
    private lazy var checkButton: UIButton = {
       let button = UIButton()
        button.setImage(UIImage(systemName: "circle"), for: .normal)
        button.contentHorizontalAlignment = .fill
        button.contentVerticalAlignment = .fill
        button.imageView?.contentMode = .scaleAspectFill
        button.tintColor = store.habits[rightIndex].color
        button.addTarget(self, action: #selector(changeCheck), for: .touchDown)
        
        
        return button
    }()
    
    //MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        contentView.backgroundColor = .white
        setupHierarchy()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Setup Hierarchy
    
    private func setupHierarchy() {
        contentView.addSubview(habitLabel)
        contentView.addSubview(timeLabel)
        contentView.addSubview(counterLabel)
        contentView.addSubview(checkButton)
    }
    
    //MARK: - Setup Layout
    
    private func setupLayout() {
        
        habitLabel.translatesAutoresizingMaskIntoConstraints = false
        habitLabel.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor, constant: 20).isActive = true
        habitLabel.leadingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.leadingAnchor, constant: 20).isActive = true
        
        timeLabel.translatesAutoresizingMaskIntoConstraints = false
        timeLabel.topAnchor.constraint(equalTo: habitLabel.bottomAnchor, constant: 10).isActive = true
        timeLabel.leadingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.leadingAnchor, constant: 20).isActive = true
        
        counterLabel.translatesAutoresizingMaskIntoConstraints = false
        counterLabel.topAnchor.constraint(equalTo: timeLabel.bottomAnchor, constant: 40).isActive = true
        counterLabel.leadingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.leadingAnchor, constant: 20).isActive = true
        counterLabel.bottomAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.bottomAnchor, constant: -20).isActive = true
        
        checkButton.translatesAutoresizingMaskIntoConstraints = false
        checkButton.centerYAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.centerYAnchor).isActive = true
        checkButton.trailingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.trailingAnchor, constant: -10).isActive = true
        checkButton.widthAnchor.constraint(equalToConstant: 45).isActive = true
        checkButton.heightAnchor.constraint(equalToConstant: 45).isActive = true
        
    }
    
    //MARK: - Button Action
    
    @objc func changeCheck() {
        if store.habits[rightIndex].isAlreadyTakenToday == false {
            store.track(store.habits[rightIndex])
            checkButton.setImage(UIImage(systemName: "checkmark.circle.fill"), for: .normal)
            (superview as? UICollectionView)?.reloadData()
        }
    }
}
