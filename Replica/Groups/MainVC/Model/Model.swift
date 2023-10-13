//
//  Model.swift
//  Replica
//
//  Created by Haydar Bekmuradov on 12.10.23.
//

import Foundation
import RealmSwift

class Model: Object {
    @objc dynamic var name = ""
    @objc dynamic var instructions = ""
    @objc dynamic var ingridients = ""
    @objc dynamic var photo = ""
    @objc dynamic var photoPath = ""
}

protocol UpdateModelAfterAddNewRepiceDelegate: AnyObject {
    func update()
}
