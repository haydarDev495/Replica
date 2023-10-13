//
//  AddRecipeVC.swift
//  Replica
//
//  Created by Haydar Bekmuradov on 13.10.23.
//

import UIKit
import RealmSwift

class AddRecipeVC: UIViewController {
    
    // - UI
    private let recipeNameTextField = UITextField()
    private let ingredientsTextView = UITextView()
    private let instructionsTextView = UITextView()
    private let imageButton = UIButton(type: .system)
    private let saveButton = UIButton(type: .system)
    private let cancelButton = UIButton(type: .system)
    
    // - Data
    private var name = false
    private let realm = try! Realm()

    // - Delegate
    weak var delegate: UpdateModelAfterAddNewRepiceDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    @objc func selectImage() {
        if let text = recipeNameTextField.text {
            text.isEmpty ? setRecipeNameAlert() : pickImage()
        }
    }
    
    @objc func saveRecipe() {
        if let nameText = recipeNameTextField.text  {
            if !nameText.isEmpty {
                let model = Model()
                model.name = nameText
                model.ingridients = ingredientsTextView.text
                model.instructions = instructionsTextView.text
                
                let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
                let imageFileName = "\(model.name).jpg"
                let imagePath = documentsDirectory.appendingPathComponent(imageFileName)
                
                model.photoPath = "\(imagePath)"
                
                do {
                    try realm.write {
                        realm.add(model)
                    }
                    delegate?.update()
                    successAlert()
                } catch {
                    print("Ошибка при записи рецепта в Realm: \(error.localizedDescription)")
                }
            } else {
                errorAlert()
            }
        }
    }
    
    @objc func cancelAdding() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        guard let searchText = textField.text else { return }
        name = searchText.isEmpty
    }
    
    func pickImage() {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = .photoLibrary
        present(imagePicker, animated: true, completion: nil)
    }

}

// MARK: -
// MARK: Configure
private extension AddRecipeVC {
    
    func configure() {
        configureUI()
    }
    
    func configureUI() {
        recipeNameTextField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)

        view.backgroundColor = .white
        
        recipeNameTextField.placeholder = "Название рецепта"
        recipeNameTextField.borderStyle = .roundedRect
        
        ingredientsTextView.text = "Ингредиенты"
        ingredientsTextView.textColor = .lightGray
        ingredientsTextView.layer.borderColor = UIColor.lightGray.cgColor
        ingredientsTextView.layer.borderWidth = 1
        ingredientsTextView.layer.cornerRadius = 6
        
        instructionsTextView.text = "Инструкции по приготовлению"
        instructionsTextView.textColor = .lightGray
        instructionsTextView.layer.borderColor = UIColor.lightGray.cgColor
        instructionsTextView.layer.borderWidth = 1
        instructionsTextView.layer.cornerRadius = 6
        
        recipeNameTextField.delegate = self
        ingredientsTextView.delegate = self
        instructionsTextView.delegate = self
        
        imageButton.setTitle("Выбрать изображение", for: .normal)
        saveButton.setTitle("Сохранить", for: .normal)
        cancelButton.setTitle("Отмена", for: .normal)
        
        view.addSubview(recipeNameTextField)
        view.addSubview(ingredientsTextView)
        view.addSubview(instructionsTextView)
        view.addSubview(imageButton)
        view.addSubview(saveButton)
        view.addSubview(cancelButton)
        
        recipeNameTextField.translatesAutoresizingMaskIntoConstraints = false
        ingredientsTextView.translatesAutoresizingMaskIntoConstraints = false
        instructionsTextView.translatesAutoresizingMaskIntoConstraints = false
        imageButton.translatesAutoresizingMaskIntoConstraints = false
        saveButton.translatesAutoresizingMaskIntoConstraints = false
        cancelButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            recipeNameTextField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            recipeNameTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            recipeNameTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            ingredientsTextView.topAnchor.constraint(equalTo: recipeNameTextField.bottomAnchor, constant: 20),
            ingredientsTextView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            ingredientsTextView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            ingredientsTextView.heightAnchor.constraint(equalToConstant: 100),
            
            instructionsTextView.topAnchor.constraint(equalTo: ingredientsTextView.bottomAnchor, constant: 20),
            instructionsTextView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            instructionsTextView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            instructionsTextView.heightAnchor.constraint(equalToConstant: 100),
            
            imageButton.topAnchor.constraint(equalTo: instructionsTextView.bottomAnchor, constant: 20),
            imageButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            saveButton.topAnchor.constraint(equalTo: imageButton.bottomAnchor, constant: 20),
            saveButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            cancelButton.topAnchor.constraint(equalTo: saveButton.bottomAnchor, constant: 20),
            cancelButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        
        imageButton.addTarget(self, action: #selector(selectImage), for: .touchUpInside)
        saveButton.addTarget(self, action: #selector(saveRecipe), for: .touchUpInside)
        cancelButton.addTarget(self, action: #selector(cancelAdding), for: .touchUpInside)
    }
    
    func setRecipeNameAlert() {
        let alert = UIAlertController(title: "", message: "Введите имя рецепта", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "ОК", style: .cancel, handler: nil)
        alert.addAction(okAction)
        present(alert, animated: true, completion: nil)
    }
    
    func errorAlert() {
        let alert = UIAlertController(title: "Ошибка", message: "при записи рецепта", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "ОК", style: .cancel, handler: nil)
        alert.addAction(okAction)
        present(alert, animated: true, completion: nil)
    }
    
    func successAlert() {
        let alert = UIAlertController(title: "Успех", message: "Рецепт сохранен успешно", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "ОК", style: .cancel) { [weak self]_ in
                guard let sSelf = self else { return }
                sSelf.navigationController?.popViewController(animated: true)
            }
        
        alert.addAction(okAction)
        present(alert, animated: true, completion: nil)
    }
    
    func saveRecipeImage(image: UIImage, recipeName: String) {
        guard let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else { return }
        let imageFileName = "\(recipeName).jpg"
        let imagePath = documentsDirectory.appendingPathComponent(imageFileName)
        
        if let imageData = image.jpegData(compressionQuality: 1.0) {
            try? imageData.write(to: imagePath)
        }
    }
}

// MARK: -
// MARK: TextView
extension AddRecipeVC: UITextViewDelegate {
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.text == "Ингредиенты" || textView.text == "Инструкции по приготовлению" {
            textView.text = ""
            textView.textColor = .black
        }
    }
}

// MARK: -
// MARK: TextFiled
extension AddRecipeVC: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return false
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
}

extension AddRecipeVC: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
        if let pickedImage = info[.originalImage] as? UIImage {
            if let text = recipeNameTextField.text {
                saveRecipeImage(image: pickedImage, recipeName: text)
            }
        }
        dismiss(animated: true, completion: nil)
    }

    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
}
