import Foundation
import FirebaseFirestore

class IngredientDAO {
    private let firestore = Firestore.firestore()
    
    func mapIngredients(documents : [QueryDocumentSnapshot]) -> [IngredientDTO] {
        return documents.map {
            (doc) -> IngredientDTO in
            return self.jsonToIngredient(doc: doc)
        }
    }
    
    func jsonToIngredient(doc: QueryDocumentSnapshot) -> IngredientDTO {
        return IngredientDTO(id: doc.documentID, name: doc["name"] as? String ?? "", isAllergen: doc["isAllergen"] as? Bool ?? false, category: doc["category"] as? String ?? "", price: doc["price"] as? String ?? "", unit: doc["unit"] as? String ?? "", stock: doc["stock"] as? Double ?? 0, allergenCategory: doc["allergenCategory"] as? String ?? nil)
    }
    
    func jsonToIngredient(doc: [String : AnyObject]) -> IngredientDTO {
        return IngredientDTO(id: doc["id"] as? String ?? nil, name: doc["name"] as? String ?? "", isAllergen: doc["isAllergen"] as? Bool ?? false, category: doc["category"] as? String ?? "", price: doc["price"] as? String ?? "", unit: doc["unit"] as? String ?? "", stock: doc["stock"] as? Double ?? 0, allergenCategory: doc["allergenCategory"] as? String ?? nil)
    }
    
    func ingToJson(ingredient: IngredientDTO) -> [String: Any] {
        var ingDictionnary: [String : Any] = [String : Any]()
        ingDictionnary["name"] = ingredient.name
        ingDictionnary["category"] = ingredient.category
        ingDictionnary["price"] = ingredient.price
        ingDictionnary["stock"] = ingredient.stock
        ingDictionnary["isAllergen"] = ingredient.isAllergen
        ingDictionnary["unit"] = ingredient.unit
        if(ingredient.allergenCategory != nil) {
            ingDictionnary["allergenCategory"] = ingredient.allergenCategory
        }
        
        return ingDictionnary
    }
    
    func updateOrAddIngredient(ing: IngredientDTO) {
        let ingDictionnary = ingToJson(ingredient: ing)
        if let documentId = ing.id {
            do {
                try firestore.collection("Ingredients").document(documentId).setData(ingDictionnary)
            }
            catch {
              print(error)
            }
        }
        else {
            firestore.collection("Ingredients").addDocument(data: ingDictionnary)
        }
    }
    
    func deleteIngredient(ing : IngredientDTO) {
        if let documentId = ing.id {
            do {
                try firestore.collection("Ingredients").document(documentId).delete()
            }
            catch {
              print(error)
            }
        }
    }
}
