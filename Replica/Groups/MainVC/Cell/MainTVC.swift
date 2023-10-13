//
//  MainTVC.swift
//  Replica
//
//  Created by Haydar Bekmuradov on 12.10.23.
//

import UIKit

class MainTVC: UITableViewCell {
    
    // - UI
    let nameLabel = UILabel()
    let recipeImageView = UIImageView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configure()
    }
    
    func setupUI(model: Model) {
        nameLabel.text = model.name
        if model.photo.isEmpty {
            print(model.photoPath)
            displayImageForRecipe(model.photoPath)
        } else {
            recipeImageView.image = UIImage(named: model.photo)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: -
// MARK: Configure
private extension MainTVC {
    
    func configure() {
        configureUI()
        self.selectionStyle = .none
    }
    
    func configureUI() {
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        recipeImageView.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(nameLabel)
        addSubview(recipeImageView)
        
        NSLayoutConstraint.activate([
            nameLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: -4),
//            nameLabel.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            nameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            nameLabel.trailingAnchor.constraint(lessThanOrEqualTo: recipeImageView.leadingAnchor, constant: -8),

            recipeImageView.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            recipeImageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),
            recipeImageView.widthAnchor.constraint(equalToConstant: 80),
            recipeImageView.heightAnchor.constraint(equalToConstant: 60),
        ])
    }
    
    func displayImageForRecipe(_ recipeName: String) {
        if let imagePath = getImagePath(forRecipeName: recipeName) {
            if let image = UIImage(contentsOfFile: imagePath.path) {
                recipeImageView.image = image
            } else {
                print("Изображение не может быть загружено из пути: \(imagePath.path)")
            }
        } else {
            print("Путь к изображению для рецепта не существует")
        }
    }

    
    func getImagePath(forRecipeName recipeName: String) -> URL? {
        let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        let imageFileName = "\(recipeName).jpg"
        let imagePath = documentsDirectory.appendingPathComponent(imageFileName)
        return imagePath
    }

}
