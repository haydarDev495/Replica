//
//  NavigationManager.swift
//  Replica
//
//  Created by Haydar Bekmuradov on 13.10.23.
//

import UIKit
import RealmSwift

class NavigationManager {
    
    private unowned var viewController: UIViewController
    
    init(viewController: UIViewController) {
        self.viewController = viewController
    }
    
    func showAddRecipeVC() {
        let vc = UIStoryboard(name: "AddRecipe", bundle: nil).instantiateInitialViewController() as! AddRecipeVC
        vc.delegate = viewController.self as? any UpdateModelAfterAddNewRepiceDelegate
        viewController.navigationController?.pushViewController(vc, animated: true)
    }
    
    func showDetailVC(indexPath: IndexPath, items: Results<Model>) {
        let vc = UIStoryboard(name: "DetailVC", bundle: nil).instantiateViewController(withIdentifier: "DetailVC") as! DetailVC
        vc.recipe = items[indexPath.row]
        viewController.navigationController?.pushViewController(vc, animated: true)
    }
}
