import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift
import Combine

class IngredientsVM : ObservableObject{
    @Published var ingredients: [IngredientDTO] = []
    
    private let firestore = Firestore.firestore()
    var data : QuerySnapshot?
    
    init() {
        Task{ 
           await self.getIngredients()
        }
    }
    
    func getIngredients() async {
        self.data = try? await firestore.collection("Ingredients").getDocuments()
        firestore.collection("Ingredients").addSnapshotListener{ (data, error) in
            guard let documents = data?.documents else { return }
            self.ingredients = documents.map {
                (doc) -> IngredientDTO in
                return IngredientDTO(id: doc.documentID, name: doc["name"] as? String ?? "", isAllergen: doc["isAllergern"] as? Bool ?? false, category: doc["category"] as? String ?? "", price: doc["price"] as? String ?? "", unit: doc["unit"] as? String ?? "", stock: doc["stock"] as? Double ?? 0, allergenCategory: doc["allergenCategory"] as? String ?? nil)
            }
        }
    }
}
