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
    let recipeNameTextField = UITextField()
    let ingredientsTextView = UITextView()
    let instructionsTextView = UITextView()
    let imageButton = UIButton(type: .system)
    let saveButton = UIButton(type: .system)
    let cancelButton = UIButton(type: .system)
    
    // - Data
    private var name = false
    private let realm = try! Realm()

    // - Delegate
    weak var delegate: UpdateModelAfterAddNewRepiceDelegate?
    
    // - Manager
    private var layout: AddRecipeLayoutManager!
    
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
        configureLAyout()
        configureUI()
    }
    
    func configureLAyout() {
        layout = AddRecipeLayoutManager(viewContoller: self)
    }
    func configureUI() {
        recipeNameTextField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        
        recipeNameTextField.delegate = self
        ingredientsTextView.delegate = self
        instructionsTextView.delegate = self
        
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
