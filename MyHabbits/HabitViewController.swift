//
//  HabitViewController.swift
//  MyHabbits
//
//  Created by Борис Киселев on 05.01.2023.
//

import UIKit

class HabitViewController: UIViewController, UIColorPickerViewControllerDelegate {
    
    var text = ""
    
    //MARK: - Subview's
    
    private lazy var nameLabel: UILabel = {
       let nameLabel = UILabel()
        nameLabel.text = "НАЗВАНИЕ"
        nameLabel.font = UIFont(name: "HelveticaNeue-Bold", size: HabitFontSize.headlineSize.rawValue)
        nameLabel.textColor = .black
        
       return nameLabel
    }()
    
    private lazy var habitField: UITextField = {
       let textField = UITextField()
        textField.placeholder = "Бегать по утрам, спать 8 часов и т.п."
        textField.addTarget(self, action: #selector(saveText), for: .editingChanged)
        
        return textField
    }()
    
    private lazy var colorLabel: UILabel = {
       let colorLabel = UILabel()
        colorLabel.text = "ЦВЕТ"
        colorLabel.font = UIFont(name: "HelveticaNeue-Bold", size: HabitFontSize.headlineSize.rawValue)
        colorLabel.textColor = .black
        
        return colorLabel
    }()
    
    private lazy var colorButton: UIButton = {
       let colorButton = UIButton()
        colorButton.setImage(UIImage(systemName: "circle.fill", withConfiguration: UIImage.SymbolConfiguration(pointSize: 32.0)), for: .normal)
        colorButton.tintColor = .systemOrange
        colorButton.addTarget(self, action: #selector(changeColor), for: .touchDown)
        
        return colorButton
    }()
    
    private lazy var timeLabel: UILabel = {
       let timeLabel = UILabel()
        timeLabel.text = "ВРЕМЯ"
        timeLabel.font = UIFont(name: "HelveticaNeue-Bold", size: HabitFontSize.headlineSize.rawValue)
        timeLabel.textColor = .black
        
        return timeLabel
    }()
    
    private lazy var habitTime: UILabel = {
       let habitTime = UILabel()
        habitTime.text = "Каждый день в "
        habitTime.font = UIFont(name: "HelveticaNeue", size: HabitFontSize.casualTextSize.rawValue)
        habitTime.textColor = .black
        
        return habitTime
    }()
    
    private lazy var time: UILabel = {
       let time = UILabel()
        time.textColor = .purple
        time.font = UIFont(name: "HelveticaNeue", size: HabitFontSize.casualTextSize.rawValue)
        time.text = formatter(with: timePicker.date)
        
        return time
    }()
    
    private lazy var timePicker: UIDatePicker = {
       let timePicker = UIDatePicker()
        timePicker.preferredDatePickerStyle = .wheels
        timePicker.datePickerMode = .time
        timePicker.addTarget(self, action: #selector(changeTime), for: .valueChanged)
        
        return timePicker
    }()
    
    //MARK: - Lifecycle
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .white
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = navigationController?.navigationBar.standardAppearance
        
        title = "Создать"
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Отменить", style: .plain, target: self, action: #selector(getBack))
        navigationItem.leftBarButtonItem?.tintColor = .purple
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Сохранить", style: .plain, target: self, action: #selector(saveHabit))
        navigationItem.rightBarButtonItem?.tintColor = .purple
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupHierarchy()
        setupLayout()
    }
    
    //MARK: - Setup Hierarchy
    
    private func setupHierarchy() {
        view.addSubview(nameLabel)
        view.addSubview(habitField)
        view.addSubview(colorLabel)
        view.addSubview(colorButton)
        view.addSubview(timeLabel)
        view.addSubview(habitTime)
        view.addSubview(time)
        view.addSubview(timePicker)
    }
    
    //MARK: - Setup Layout
    
    private func setupLayout() {
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20).isActive = true
        nameLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20).isActive = true
        
        habitField.translatesAutoresizingMaskIntoConstraints = false
        habitField.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 15).isActive = true
        habitField.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20).isActive = true
        habitField.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20).isActive = true
        
        colorLabel.translatesAutoresizingMaskIntoConstraints = false
        colorLabel.topAnchor.constraint(equalTo: habitField.bottomAnchor, constant: 20).isActive = true
        colorLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20).isActive = true
        
        colorButton.translatesAutoresizingMaskIntoConstraints = false
        colorButton.topAnchor.constraint(equalTo: colorLabel.bottomAnchor, constant: 15).isActive = true
        colorButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20).isActive = true
        
        timeLabel.translatesAutoresizingMaskIntoConstraints = false
        timeLabel.topAnchor.constraint(equalTo: colorButton.bottomAnchor, constant: 20).isActive = true
        timeLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20).isActive = true
        
        habitTime.translatesAutoresizingMaskIntoConstraints = false
        habitTime.topAnchor.constraint(equalTo: timeLabel.bottomAnchor, constant: 15).isActive = true
        habitTime.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20).isActive = true
        
        time.translatesAutoresizingMaskIntoConstraints = false
        time.topAnchor.constraint(equalTo: timeLabel.bottomAnchor, constant: 15).isActive = true
        time.leadingAnchor.constraint(equalTo: habitTime.trailingAnchor, constant: 1).isActive = true
        
        timePicker.translatesAutoresizingMaskIntoConstraints = false
        timePicker.topAnchor.constraint(equalTo: time.bottomAnchor, constant: 20).isActive = true
        timePicker.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20).isActive = true
        timePicker.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20).isActive = true
    }
  
    //MARK: - Button's Action's
    
    @objc func getBack() {
        dismiss(animated: true)
        print("get back")
    }
    
    @objc func saveHabit() {
        if text != "" {
            let newHabit = Habit(name: text, date: timePicker.date, color: colorButton.tintColor)
            store.habits.append(newHabit)
            store.save()
            dismiss(animated: true)
        } else {
            let alert = UIAlertController(title: "Ошибка", message: "Вы не заполнили Название привычки", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ок", style: .cancel))
            
            self.present(alert, animated: true)
        }
    }
    
    @objc func saveText() {
        if habitField.text != "" {
            text = habitField.text ?? ""
        }
    }
    
    @objc func changeColor() {
        let picker = UIColorPickerViewController()
        picker.delegate = self
        picker.modalPresentationStyle = .fullScreen
        picker.modalTransitionStyle = .crossDissolve
        self.present(picker, animated: true)
    }
    
    @objc func changeTime() {
        time.text = formatter(with: timePicker.date)
    }
    
    //MARK: - ColorPicker func
    
    func colorPickerViewController(_ viewController: UIColorPickerViewController, didSelect color: UIColor, continuously: Bool) {
        colorButton.tintColor = color
    }
}
