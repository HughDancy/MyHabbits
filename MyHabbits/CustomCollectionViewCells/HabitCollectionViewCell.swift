//
//  HabitCollectionViewCell.swift
//  MyHabbits
//
//  Created by Борис Киселев on 10.01.2023.
//

import UIKit

protocol MyTableViewCellDelegate: AnyObject {
    func didTapButton()
}

class HabitCollectionViewCell: UICollectionViewCell {
    
    weak var delegate: MyTableViewCellDelegate?
    
    let reuseId = "habitCell"
    let time = ""
    var cellIndex = 0
    var subscribeBtn: (() -> ())?
    
    //MARK: - Subview's
    
    private let habitLabel: UILabel = {
       let label = UILabel()
        label.font = UIFont(name: "HelveticaNeue", size: HabitFontSize.headlineSize.rawValue)
        
        return label
    }()
    
    private lazy var timeLabel: UILabel = {
       let label = UILabel()
        label.font = UIFont(name: "HelveticaNeue", size: HabitFontSize.casualTextSize.rawValue)
        label.textColor = .lightGray
        label.text = "Каждый день в \(time)"
        
        return label
    }()
    
    private let counterLabel: UILabel = {
       let label = UILabel()
        label.font = UIFont(name: "HelveticaNeue", size: HabitFontSize.casualTextSize.rawValue)
        label.textColor = .lightGray
      
        return label
    }()

   lazy var checkButton: UIButton = {
        let button = UIButton()
        button.contentHorizontalAlignment = .fill
        button.contentVerticalAlignment = .fill
        button.imageView?.contentMode = .scaleAspectFill
       
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
        contentView.addSubview(checkButton)
        contentView.addSubview(habitLabel)
        contentView.addSubview(timeLabel)
        contentView.addSubview(counterLabel)
    }
    
    //MARK: - Setup Layout
    
    private func setupLayout() {
        
        habitLabel.translatesAutoresizingMaskIntoConstraints = false
        habitLabel.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor, constant: 30).isActive = true
        habitLabel.leadingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.leadingAnchor, constant: 20).isActive = true
        
        timeLabel.translatesAutoresizingMaskIntoConstraints = false
        timeLabel.topAnchor.constraint(equalTo: habitLabel.bottomAnchor, constant: 10).isActive = true
        timeLabel.leadingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.leadingAnchor, constant: 20).isActive = true
        
        counterLabel.translatesAutoresizingMaskIntoConstraints = false
        counterLabel.topAnchor.constraint(equalTo: checkButton.bottomAnchor, constant: 20).isActive = true
        counterLabel.leadingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.leadingAnchor, constant: 20).isActive = true
        counterLabel.bottomAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.bottomAnchor, constant: -20).isActive = true
        
        checkButton.translatesAutoresizingMaskIntoConstraints = false
        checkButton.centerYAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.centerYAnchor).isActive = true
        checkButton.trailingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.trailingAnchor, constant: -10).isActive = true
        checkButton.widthAnchor.constraint(equalToConstant: 45).isActive = true
        checkButton.heightAnchor.constraint(equalToConstant: 45).isActive = true
    }
    
    override func layoutSubviews() {
           super.layoutSubviews()
           if !(__CGSizeEqualToSize(bounds.size,self.intrinsicContentSize)){
               self.invalidateIntrinsicContentSize()
           }
       }
    
    //MARK: - Button Action
    
    @objc func changeCheck() {
        delegate?.didTapButton()
        if store.habits[cellIndex].isAlreadyTakenToday == false {
            store.track(store.habits[cellIndex])
        }
        
        checkButton.setImage(UIImage(systemName: "checkmark.circle.fill"), for: .normal)
        
    }
    
    //MARK: - Setup Date
    
    public func setupCell(with index: Int) {
        habitLabel.text = store.habits[index].name
        habitLabel.textColor = store.habits[index].color
        timeLabel.text = "Каждый день в \(formatter(with: store.habits[index].date))"
        checkButton.tintColor = store.habits[index].color
        if store.habits[index].isAlreadyTakenToday == true {
            checkButton.setImage(UIImage(systemName: "checkmark.circle.fill"), for: .normal)
        } else {
            checkButton.setImage(UIImage(systemName: "circle"), for: .normal)
        }
        
        counterLabel.text = "Счетчик: \(String(store.habits[index].trackDates.count))"

        checkButton.addTarget(self, action: #selector(changeCheck), for: .touchUpInside)
    }
}
