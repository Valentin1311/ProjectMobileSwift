//
//  Ingredient.swift
//  PMS
//
//  Created by m1 on 20/02/2022.
//

import Foundation

class IngredientDTO : Identifiable, ObservableObject {
    var id: String?
    var name: String
    var isAllergen: Bool {
        didSet{
            if (isAllergen == false) {
                allergenCategory = nil
            }
        }
    }
    var category: String
    var price: String
    var unit: String
    var stock : Double
    var allergenCategory: String?
    
    init(id: String?, name: String, isAllergern: Bool, category: String, price: String, unit: String, stock: Double, allergenCategory: String?) {
        self.id = id
        self.name = name
        self.isAllergen = isAllergern
        self.category = category
        self.price = price
        self.unit = unit
        self.stock = stock
        self.allergenCategory = allergenCategory
    }
}
