//
//  AddRecipeLayoutManager.swift
//  Replica
//
//  Created by Haydar Bekmuradov on 13.10.23.
//

import UIKit

class AddRecipeLayoutManager {
    private var vc: AddRecipeVC
    
    init(viewContoller: AddRecipeVC) {
        self.vc = viewContoller
        configure()
    }
}

// MARK: -
// MARK: Configure
private extension AddRecipeLayoutManager {
    
    func configure() {
        configureUI()
    }
    
    func configureUI() {
        vc.title = "Новый рецепт"
        vc.view.backgroundColor = .white
        
        vc.recipeNameTextField.placeholder = "Название рецепта"
        vc.recipeNameTextField.borderStyle = .roundedRect
        
        vc.ingredientsTextView.text = "Ингредиенты"
        vc.ingredientsTextView.textColor = .lightGray
        vc.ingredientsTextView.layer.borderColor = UIColor.lightGray.cgColor
        vc.ingredientsTextView.layer.borderWidth = 1
        vc.ingredientsTextView.layer.cornerRadius = 6
        
        vc.instructionsTextView.text = "Инструкции по приготовлению"
        vc.instructionsTextView.textColor = .lightGray
        vc.instructionsTextView.layer.borderColor = UIColor.lightGray.cgColor
        vc.instructionsTextView.layer.borderWidth = 1
        vc.instructionsTextView.layer.cornerRadius = 6
        
        
        vc.imageButton.setTitle("Выбрать изображение", for: .normal)
        vc.saveButton.setTitle("Сохранить", for: .normal)
        vc.cancelButton.setTitle("Отмена", for: .normal)
        
        vc.view.addSubview(vc.recipeNameTextField)
        vc.view.addSubview(vc.ingredientsTextView)
        vc.view.addSubview(vc.instructionsTextView)
        vc.view.addSubview(vc.imageButton)
        vc.view.addSubview(vc.saveButton)
        vc.view.addSubview(vc.cancelButton)
        
        vc.recipeNameTextField.translatesAutoresizingMaskIntoConstraints = false
        vc.ingredientsTextView.translatesAutoresizingMaskIntoConstraints = false
        vc.instructionsTextView.translatesAutoresizingMaskIntoConstraints = false
        vc.imageButton.translatesAutoresizingMaskIntoConstraints = false
        vc.saveButton.translatesAutoresizingMaskIntoConstraints = false
        vc.cancelButton.translatesAutoresizingMaskIntoConstraints = false
        
        
        vc.view.addSubview(vc.recipeNameTextField)
        vc.view.addSubview(vc.ingredientsTextView)
        vc.view.addSubview(vc.instructionsTextView)
        vc.view.addSubview(vc.imageButton)
        vc.view.addSubview(vc.saveButton)
        vc.view.addSubview(vc.cancelButton)

        NSLayoutConstraint.activate([
            vc.recipeNameTextField.topAnchor.constraint(equalTo: vc.view.safeAreaLayoutGuide.topAnchor, constant: 20),
            vc.recipeNameTextField.leadingAnchor.constraint(equalTo: vc.view.leadingAnchor, constant: 20),
            vc.recipeNameTextField.trailingAnchor.constraint(equalTo: vc.view.trailingAnchor, constant: -20),
            
            vc.ingredientsTextView.topAnchor.constraint(equalTo: vc.recipeNameTextField.bottomAnchor, constant: 20),
            vc.ingredientsTextView.leadingAnchor.constraint(equalTo: vc.view.leadingAnchor, constant: 20),
            vc.ingredientsTextView.trailingAnchor.constraint(equalTo: vc.view.trailingAnchor, constant: -20),
            vc.ingredientsTextView.heightAnchor.constraint(equalToConstant: 100),
            
            vc.instructionsTextView.topAnchor.constraint(equalTo: vc.ingredientsTextView.bottomAnchor, constant: 20),
            vc.instructionsTextView.leadingAnchor.constraint(equalTo: vc.view.leadingAnchor, constant: 20),
            vc.instructionsTextView.trailingAnchor.constraint(equalTo: vc.view.trailingAnchor, constant: -20),
            vc.instructionsTextView.heightAnchor.constraint(equalToConstant: 100),
            
            vc.imageButton.topAnchor.constraint(equalTo: vc.instructionsTextView.bottomAnchor, constant: 20),
            vc.imageButton.centerXAnchor.constraint(equalTo: vc.view.centerXAnchor),
            
            vc.saveButton.topAnchor.constraint(equalTo: vc.imageButton.bottomAnchor, constant: 20),
            vc.saveButton.centerXAnchor.constraint(equalTo: vc.view.centerXAnchor),
            
            vc.cancelButton.topAnchor.constraint(equalTo: vc.saveButton.bottomAnchor, constant: 20),
            vc.cancelButton.centerXAnchor.constraint(equalTo: vc.view.centerXAnchor)
        ])

    }
}
