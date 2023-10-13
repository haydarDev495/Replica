//
//  MainLayoutManager.swift
//  Replica
//
//  Created by Haydar Bekmuradov on 13.10.23.
//

import UIKit

class MainLayoutManager {
    
    private var vc: MainVC
    
    init(vc: MainVC) {
        self.vc = vc
        configure()
    }
}

// MARK: -
// MARK: Configure
private extension MainLayoutManager {
    
    func configure() {
        vc.view.backgroundColor = .white
        vc.title = "Recipes"
        configureUI()
    }
    
    func configureUI() {
        vc.textField = UITextField()
        vc.textField.placeholder = "Введите текст"
        vc.textField.borderStyle = .roundedRect
        vc.textField.keyboardType = .default
        vc.textField.returnKeyType = .done
        vc.view.addSubview(vc.textField)

        vc.textField.translatesAutoresizingMaskIntoConstraints = false
        vc.textField.topAnchor.constraint(equalTo: vc.view.topAnchor, constant: 100).isActive = true
        vc.textField.centerXAnchor.constraint(equalTo: vc.view.centerXAnchor).isActive = true
        vc.textField.leadingAnchor.constraint(equalTo: vc.view.leadingAnchor, constant: 8).isActive = true
        
        vc.tableView = UITableView()
        vc.tableView.translatesAutoresizingMaskIntoConstraints = false
        vc.tableView.separatorStyle = .singleLine
        vc.view.addSubview(vc.tableView)

        vc.tableView.topAnchor.constraint(equalTo: vc.textField.bottomAnchor, constant: 8).isActive = true
        vc.tableView.leadingAnchor.constraint(equalTo: vc.view.leadingAnchor).isActive = true
        vc.tableView.trailingAnchor.constraint(equalTo: vc.view.trailingAnchor).isActive = true
        vc.tableView.bottomAnchor.constraint(equalTo: vc.view.bottomAnchor).isActive = true
    }
}
