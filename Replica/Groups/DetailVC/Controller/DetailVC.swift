//
//  DetailVC.swift
//  Replica
//
//  Created by Haydar Bekmuradov on 12.10.23.
//

import UIKit
import RealmSwift

class DetailVC: UIViewController {

    // - UI
    let recipeTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        label.textAlignment = .center
        return label
    }()
    
    let recipeImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    let ingredientsTextView = UITextView()
    let instructionsTextView = UITextView()
    
    // - Data
    var recipe: Model?
    private var isButtonToggled = false
    
    // - Manager
    private var layout: DetailVCLayoutManager!
    
    // - Constraint
    var recipeImageViewTopConstraint: NSLayoutConstraint!
    
    // - Realm
    private let realm = try! Realm()

    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    @objc func keyboardWillShow(_ notification: Notification) {
        action(value: true)
    }

    @objc func keyboardWillHide(_ notification: Notification) {
        action(value: false)
    }
    
    @objc func addRecipeTapped() {
        if isButtonToggled {
            do {
                try realm.write {
                    recipe?.ingridients = ingredientsTextView.text
                    recipe?.instructions = instructionsTextView.text
                }
            } catch {
                print("Ошибка при записи рецепта в Realm: \(error.localizedDescription)")
            }
        }
        navigationItem.rightBarButtonItem?.title = isButtonToggled ? "edit" : "save"
        ingredientsTextView.isEditable = !isButtonToggled
        instructionsTextView.isEditable = !isButtonToggled
        isButtonToggled.toggle()
    }
}

// MARK: -
// MARK: Configure
private extension DetailVC {
    
    func configure() {
        
        ingredientsTextView.isEditable = false
        instructionsTextView.isEditable = false
        
        ingredientsTextView.delegate = self
        instructionsTextView.delegate = self
        
        configureLayout()
        configureAddButton()
        configureKeyboard()
    }
    
    func configureLayout() {
        layout = DetailVCLayoutManager(vc: self)
    }
    
    func configureAddButton() {
        let addButton = UIBarButtonItem(title: "Edit", style: .plain, target: self, action: #selector(addRecipeTapped))
        navigationItem.rightBarButtonItem = addButton
    }
    
    func configureKeyboard() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)),
                                               name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)),
                                               name: UIResponder.keyboardWillHideNotification, object: nil)
        
        recipeImageViewTopConstraint = recipeImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16)
        recipeImageViewTopConstraint.isActive = true
    }
    
    func action(value: Bool) {
        recipeImageViewTopConstraint.constant = value ? -200 : 16
        layout.animate()
    }
}

// MARK: -
// MARK: TextView
extension DetailVC: UITextViewDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return false
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.text == "Ингредиенты" || textView.text == "Инструкции по приготовлению" {
            textView.text = ""
            textView.textColor = .black
        }
    }
}
