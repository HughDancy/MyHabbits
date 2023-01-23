//
//  ProgressCollectionViewCell.swift
//  MyHabbits
//
//  Created by Борис Киселев on 10.01.2023.
//

import UIKit

class ProgressCollectionViewCell: UICollectionViewCell {
    
   public let reuseId = "progressCell"
    
    //MARK: - Subview's
    
    private let youDoItLabel: UILabel = {
        let label = UILabel()
        label.text = "Все получится!"
        label.font = UIFont(name: "HelveticaNeue", size: HabitFontSize.casualTextSize.rawValue)
        label.textColor = .systemGray
        
        return label
    }()
    
    private let procentLabel: UILabel = {
       let label = UILabel()
        label.font = UIFont(name: "HelveticaNeue", size: HabitFontSize.casualTextSize.rawValue)
        label.textColor = .systemGray
        
        return label
    }()
    
    private let progressLine: UIProgressView = {
       let progressLine = UIProgressView()
        progressLine.tintColor = .lightGray
        progressLine.progressTintColor = .purple
        progressLine.layer.cornerRadius = 4
        
        return progressLine
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
    
    //MARK: - Setup data
    
    func setupData() {
        procentLabel.text = String(format: "%.0f%%", store.todayProgress * 100)
        progressLine.progress = store.todayProgress
    }
    
    //MARK: - Setup Hierarchy
    
    private func setupHierarchy() {
        contentView.addSubview(youDoItLabel)
        contentView.addSubview(procentLabel)
        contentView.addSubview(progressLine)
    }
    
    //MARK: - Setup Layout
    
    private func setupLayout() {
        
        youDoItLabel.translatesAutoresizingMaskIntoConstraints = false
        youDoItLabel.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor, constant: 15).isActive = true
        youDoItLabel.leadingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.leadingAnchor, constant: 20).isActive = true
        
        procentLabel.translatesAutoresizingMaskIntoConstraints = false
        procentLabel.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor, constant: 15).isActive = true
        procentLabel.trailingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.trailingAnchor, constant: -20).isActive = true
        
        progressLine.translatesAutoresizingMaskIntoConstraints = false
        progressLine.topAnchor.constraint(equalTo: youDoItLabel.bottomAnchor, constant: 15).isActive = true
        progressLine.leadingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.leadingAnchor, constant: 20).isActive = true
        progressLine.trailingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.trailingAnchor, constant: -20).isActive = true
        progressLine.bottomAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.bottomAnchor, constant: -15).isActive = true

    }
}
