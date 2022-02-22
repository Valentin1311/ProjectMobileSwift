import Foundation
import FirebaseFirestore

class IngredientDAO {     
    func getIngredients(documents : [QueryDocumentSnapshot]) -> [IngredientDTO] {
        return documents.map {
            (doc) -> IngredientDTO in
            return self.jsonToIngredient(doc: doc)
        }
    }
    
    func jsonToIngredient(doc: QueryDocumentSnapshot) -> IngredientDTO {
        return IngredientDTO(id: doc.documentID, name: doc["name"] as? String ?? "", isAllergern: doc["isAllergern"] as? Bool ?? false, category: doc["category"] as? String ?? "", price: doc["price"] as? String ?? "", unit: doc["unit"] as? String ?? "", stock: doc["stock"] as? Double ?? 0, allergenCategory: doc["allergenCategory"] as? String ?? nil)
    }
    
    func jsonToIngredient(doc: [String : AnyObject]) -> IngredientDTO {
        return IngredientDTO(id: doc["id"] as? String ?? nil, name: doc["name"] as? String ?? "", isAllergern: doc["isAllergern"] as? Bool ?? false, category: doc["category"] as? String ?? "", price: doc["price"] as? String ?? "", unit: doc["unit"] as? String ?? "", stock: doc["stock"] as? Double ?? 0, allergenCategory: doc["allergenCategory"] as? String ?? nil)
    }
}
