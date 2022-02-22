import Foundation
import FirebaseFirestore

class IngredientDAO {
    private let firestore = Firestore.firestore()
    var data : QuerySnapshot?
    var ingredients = [IngredientDTO]()
    
    func getIngredients() async {
        self.data = try? await firestore.collection("Ingredients").getDocuments()
        firestore.collection("Ingredients").addSnapshotListener{ (data, error) in
            guard let documents = data?.documents else { return }
            var return_ingredients = documents.map {
                (doc) -> IngredientDTO in 
                return IngredientDTO(id: doc.documentID, name: doc["name"] as? String ?? "", isAllergern: doc["isAllergern"] as? Bool ?? false, category: doc["category"] as? String ?? "", price: doc["price"] as? String ?? "", unit: doc["unit"] as? String ?? "", stock: doc["stock"] as? Double ?? 0, allergenCategory: doc["allergenCategory"] as? String ?? nil)
            }
        }
    }
}
