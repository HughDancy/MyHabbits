//
//  InformationViewController.swift
//  MyHabbits
//
//  Created by Борис Киселев on 05.01.2023.
//

import UIKit

class InformationViewController: UIViewController {
    
    //MARK: - Subview's
    
    private lazy var headingTitle: UILabel = {
       let title = UILabel()
        title.text = infoTitle
        title.font = UIFont(name: "HelveticaNeue-Bold", size: HabitFontSize.infoTitleSize.rawValue)
        title.textColor = .black
        
        return title
    }()
    
    private lazy var infoTextView: UITextView = {
       let textView = UITextView()
        textView.textColor = .black
        textView.font = UIFont(name: "HelveticaNeue", size: HabitFontSize.headlineSize.rawValue)
        textView.text = infoText
        textView.showsVerticalScrollIndicator = false
        
        return textView
    }()
    
    //MARK: - Lifecycle
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .systemGray6
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = navigationController?.navigationBar.standardAppearance
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = "Информация"
        setupHierarchy()
        setupLayout()
    }
    
    //MARK: - Setup Hierarchy
    
    private func setupHierarchy() {
        view.addSubview(headingTitle)
        view.addSubview(infoTextView)
    }

    //MARK: - Setup Layout
    
    private func setupLayout() {
        
        headingTitle.translatesAutoresizingMaskIntoConstraints = false
        headingTitle.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20).isActive = true
        headingTitle.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20).isActive = true
        
        infoTextView.translatesAutoresizingMaskIntoConstraints = false
        infoTextView.topAnchor.constraint(equalTo: headingTitle.bottomAnchor, constant: 15).isActive = true
        infoTextView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20).isActive = true
        infoTextView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20).isActive = true
        infoTextView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
    }
}
