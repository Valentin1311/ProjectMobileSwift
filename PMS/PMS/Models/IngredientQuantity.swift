//
//  IngredientQuantity.swift
//  PMS
//
//  Created by m1 on 22/02/2022.
//  Copyright © 2022 	. All rights reserved.
//

import Foundation

class IngredientQuantityDTO : IngredientDTO {
    var quantity: Int
    init(quantity: Int?, id: String?, name: String, isAllergern: Bool, category: String, price: String, unit: String, stock: Double, allergenCategory: String?) {
        self.quantity = quantity ?? 0
        super.init(id: id, name: name, isAllergern: isAllergern, category: category, price: price, unit: unit, stock: stock, allergenCategory: allergenCategory)
    }
}
