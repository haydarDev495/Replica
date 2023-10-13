//
//  DetailVCLayoutManager.swift
//  Replica
//
//  Created by Haydar Bekmuradov on 13.10.23.
//

import UIKit

class DetailVCLayoutManager {
    
    private var vc: DetailVC
    
    init(vc: DetailVC) {
        self.vc = vc
        configure()
    }
    
    func animate() {
        UIView.animate(withDuration: 0.33) { [weak self] in
            guard let sSelf = self else { return }
            sSelf.vc.view.layoutIfNeeded()
        }
    }
}

// MARK: -
// MARK: Configure
private extension DetailVCLayoutManager {
    
    func configure() {
        vc.view.backgroundColor = .white
        configureUI()
    }
    
    func configureUI() {
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
        
        vc.view.addSubview(vc.ingredientsTextView)
        vc.view.addSubview(vc.instructionsTextView)
        
        vc.view.addSubview(vc.recipeImageView)
        vc.view.addSubview(vc.recipeTitleLabel)
        
        vc.ingredientsTextView.translatesAutoresizingMaskIntoConstraints = false
        vc.instructionsTextView.translatesAutoresizingMaskIntoConstraints = false
        
        if let recipe = vc.recipe {
            
            if let path = photoURL(photoPath: recipe.photoPath) {
                do {
                    let imageData = try Data(contentsOf: path)
                    if let image = UIImage(data: imageData) {
                        vc.recipeImageView.image = image
                    } else {
                    }
                } catch {
                    vc.recipeImageView.image = UIImage(named: recipe.photo)
                }
            }
            vc.recipeTitleLabel.text = recipe.name
            vc.ingredientsTextView.text = recipe.ingridients
            vc.instructionsTextView.text = recipe.instructions
        }
        
        NSLayoutConstraint.activate([
            
            vc.recipeImageView.topAnchor.constraint(equalTo: vc.view.safeAreaLayoutGuide.topAnchor, constant: 16),
            vc.recipeImageView.leadingAnchor.constraint(equalTo: vc.view.leadingAnchor, constant: 16),
            vc.recipeImageView.trailingAnchor.constraint(equalTo: vc.view.trailingAnchor, constant: -16),
            vc.recipeImageView.heightAnchor.constraint(equalToConstant: 200),
            
            vc.recipeTitleLabel.topAnchor.constraint(equalTo: vc.recipeImageView.bottomAnchor, constant: 16),
            vc.recipeTitleLabel.leadingAnchor.constraint(equalTo: vc.view.leadingAnchor, constant: 16),
            vc.recipeTitleLabel.trailingAnchor.constraint(equalTo: vc.view.trailingAnchor, constant: -16),
            
            
            vc.ingredientsTextView.topAnchor.constraint(equalTo: vc.recipeTitleLabel.bottomAnchor, constant: 20),
            vc.ingredientsTextView.leadingAnchor.constraint(equalTo: vc.view.leadingAnchor, constant: 20),
            vc.ingredientsTextView.trailingAnchor.constraint(equalTo: vc.view.trailingAnchor, constant: -20),
            vc.ingredientsTextView.heightAnchor.constraint(equalToConstant: 150),
            
            vc.instructionsTextView.topAnchor.constraint(equalTo: vc.ingredientsTextView.bottomAnchor, constant: 20),
            vc.instructionsTextView.leadingAnchor.constraint(equalTo: vc.view.leadingAnchor, constant: 20),
            vc.instructionsTextView.trailingAnchor.constraint(equalTo: vc.view.trailingAnchor, constant: -20),
            vc.instructionsTextView.heightAnchor.constraint(equalToConstant: 150),
        ])
    }
    
    func photoURL(photoPath: String) -> URL? {
        return URL(fileURLWithPath: photoPath)
    }
}

