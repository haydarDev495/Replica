//
//  MainVC.swift
//  Replica
//
//  Created by Haydar Bekmuradov on 12.10.23.
//

import UIKit
import RealmSwift

class MainVC: UIViewController {

    // - UI
    var tableView: UITableView!
    var textField: UITextField!
    
    // - Data
    let realm = try! Realm()
    var items: Results<Model>!

    // - Manager
    private var navigationManager: NavigationManager!
    private var layout: MainLayoutManager!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        textFiledAction()
    }
    
    @objc func addRecipeTapped() {
        navigationManager.showAddRecipeVC()
    }
}

// MARK: -
// MARK: Configure
private extension MainVC {
    
    func configure() {
        configureRealmData()
        configureLayoutManager()
        configureNavigationManager()
        configureAddButton()
        configureTextField()
        configureTableView()
    }
    
    func configureRealmData() {
        items = realm.objects(Model.self)

        if items.isEmpty {
            saveDataToRealm()
        }
    }
    
    func configureLayoutManager() {
        layout = MainLayoutManager(vc: self)
    }
    
    func configureNavigationManager() {
        navigationManager = NavigationManager(viewController: self)
    }
    
    func configureAddButton() {
        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addRecipeTapped))
        navigationItem.rightBarButtonItem = addButton
    }
    
    func configureTextField() {
        textField.delegate = self
        textField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
    }
    
    func configureTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(MainTVC.self, forCellReuseIdentifier: "MainTVC")
    }
    
    func textFiledAction() {
        guard let searchText = textField.text else { return }
        
        if searchText.isEmpty {
            items = realm.objects(Model.self)
        } else {
            let predicate = NSPredicate(format: "name CONTAINS[c] %@", searchText)
            items = realm.objects(Model.self).filter(predicate)
        }
        
        tableView.reloadData()
    }
    
    func saveDataToRealm() {
        let h = Model()
        h.name = "Хачупури"
        h.photo = "hacauri"
        h.instructions = "Подготовьте ингредиенты по списку. В теплой воде растворите соль и сахар. Добавьте дрожжи и перемешайте смесь до их растворения. Добавьте растительное масло и 100 граммов просеянной пшеничной муки. Еще раз все хорошо перемешайте, чтобы не осталось комочков муки."
        h.ingridients = "Вода - 350 мл, Сухие дрожжи - 10 г, Соль - 2 ч.л. Сахар - 1 ч.л. Мука пшеничная - 500 г, Растительное масло - 2 ст.л. Сыр сулугуни - 500 г, Имеретинский сыр/брынза - 500 г, Яйцо куриное - 5-7 шт. (по вкусу), Сливочное масло - 50 г"
        
        let k = Model()
        k.name = "Креветки"
        k.photo = "krevetki"
        k.instructions = "Это блюдо не может не понравиться вам, если вы - любитель жареных креветок, и не обязательно тигровых или королевских. Так можно приготовить абсолютно любых креветок, даже мелких, только время приготовления нужно уменьшить, и я уверяю вас - пальчики оближут все ваши гости, даже несмотря на вечерние наряды))) Для приготовления тигровых креветок, жаренных в томатном соусе, подготовьте продукты по списку. Креветки нужно предварительно разморозить, зелень помыть, обсушить."
        k.ingridients = "Креветки тигровые - 400 г, Чеснок - 1-2 зубчика, Соус томатный - 3-4 ст.л., Соевый соус - 1 ст.л., Вустерский соус - 1,5 ч.л. Жгучий соус - по вкусу, Устричный соус - 1 ч.л. Лимонный сок - 1 ч.л. Перец ч.м. - по вкусу, Розмарин - пару веточек, Масло оливковое - 3 ст.л. Петрушка - несколько веточек"
        
        let n = Model()
        n.name = "Наггетсы"
        n.photo = "naggets"
        n.ingridients = "Филе куриное - 300 г, Яйцо куриное - 2 шт. Батон белый - 100 г, Соль и перец - по вкусу, Сухари панировочные - 150 г, Масло растительное - для жарки"
        n.instructions = "Для приготовления куриных наггетсов как в макдональдсе в домашних условиях вам понадобятся все эти продукты. Если филе из заморозки - разморозьте и обсушите его."

        let p = Model()
        p.name = "Панкейки"
        p.photo = "pankeik"

        let u = Model()
        u.name = "Улитка"
        u.photo = "ulitkaPhoto"
        u.instructions = "Продукты для приготовления улиток по-бургундски (фаршированных улиток) - перед вами. Прежде всего необходимо промыть улиток от слизи. Для этого выложите их в казан или кастрюлю и залейте горячей водой. Отварите в течение 8-10 минут на умеренном нагреве."
        u.ingridients = "Улитки виноградные - 14-15 шт. Масло сливочное - 100 г, Лук зеленый - 6-7 г, Укроп - 4 г, Соль - 3 щепотки, Лавровый лист - 2 шт. Приправа «Французские травы» - 0,5 ч.л. Вино белое - 120 мл, Вода горячая - 120 мл, Чеснок - 2 зубчика"

        let ut = Model()
        ut.name = "Утиные"
        ut.photo = "utinie"
        ut.ingridients = "Утиные ножки - 2 шт. Чеснок - 2-3 зубчика, Тимьян сушеный - 0,5 ч.л. Соль - 0,5 ч.л. Перец черный молотый - 3 щепотки, Жир утиный - 3 ст.л. Вода горячая - 150 мл"
        ut.instructions = "Возьмите необходимые ингредиенты для приготовления утиных ножек «Конфи» и начнем кулинарить! Помните, что создание блюда за сутки до запекания начинается с маринования ножек!"
        do {
            try self.realm.write {
                self.realm.add([h, k, n, p, u, ut])
            }
        } catch let error {
            print("error save data first time: \(error)")
        }
    }
}

// MARK: -
// MARK: TextFiled
extension MainVC: UITextFieldDelegate {

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

// MARK: -
// MARK: TableviewDelegates
extension MainVC: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MainTVC", for: indexPath) as! MainTVC
        cell.setupUI(model: items[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        navigationManager.showDetailVC(indexPath: indexPath, items: items)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let editingRow = items[indexPath.row]
            try! self.realm.write {
                self.realm.delete(editingRow)
            }
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
}

// MARK: -
// MARK: Update
extension MainVC: UpdateModelAfterAddNewRepiceDelegate {
    func update() {
        tableView.reloadData()
    }
}
