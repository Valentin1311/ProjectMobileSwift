//
//  IngredientQuantityDAO.swift
//  PMS
//
//  Created by m1 on 22/02/2022.
//  Copyright © 2022 	. All rights reserved.
//

import Foundation
import FirebaseFirestore

class IngredientQuantityDAO {
    
    func jsonToIngredientQuantity(doc: [String : AnyObject]) -> IngredientQuantityDTO {
        return IngredientQuantityDTO(quantity: doc["quantity"] as? Int ?? nil, id: doc["id"] as? String ?? nil, name: doc["name"] as? String ?? "", isAllergen: doc["isAllergen"] as? Bool ?? false, category: doc["category"] as? String ?? "", price: doc["price"] as? String ?? "", unit: doc["unit"] as? String ?? "", stock: doc["stock"] as? Double ?? 0, allergenCategory: doc["allergenCategory"] as? String ?? nil)
    }
    
    func jsonToIngredientQuantity(doc: QueryDocumentSnapshot) -> IngredientQuantityDTO {
        return IngredientQuantityDTO(quantity: doc["quantity"] as? Int ?? nil, id: doc["id"] as? String ?? nil, name: doc["name"] as? String ?? "", isAllergen: doc["isAllergen"] as? Bool ?? false, category: doc["category"] as? String ?? "", price: doc["price"] as? String ?? "", unit: doc["unit"] as? String ?? "", stock: doc["stock"] as? Double ?? 0, allergenCategory: doc["allergenCategory"] as? String ?? nil)
    }
}
