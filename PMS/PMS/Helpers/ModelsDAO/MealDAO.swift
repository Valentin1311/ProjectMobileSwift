import Foundation
import FirebaseFirestore

class MealDAO {
    private let firestore = Firestore.firestore()
    
    func mapMeals(documents : [QueryDocumentSnapshot]) -> [MealDTO]{
        return documents.map {(doc) -> MealDTO in
            return MealDTO(id: doc.documentID, name: doc["name"] as? String ?? "", manager: doc["manager"] as? String ?? "", category: doc["category"] as? String ?? "",
                           nbGuests: doc["nbGuests"] as? Int ?? 1, stageList: (doc["stageList"] as! [[String : AnyObject]]).map{
                (doc) -> StageDTO in
                return StageDAO().jsonToStage(doc : doc)
            }, matS: doc["matS"] as? String ?? "", matD: doc["matD"] as? String ?? "", coefVenteHT: doc["coefVenteHT"] as? Int ?? nil, coefVenteTTC: doc["coefVenteTTC"] as? Int ?? nil, coutHFluide: doc["coutHFluide"] as? Int ?? nil, coutHMoyen: doc["coutHMoyen"] as? Int ?? nil)
        }
    }
    
    func mealToJson(meal: MealDTO) -> [String: Any] {
        var mealDictionnary: [String : Any] = [String : Any]()
        mealDictionnary["name"] = meal.name
        mealDictionnary["manager"] = meal.manager
        mealDictionnary["category"] = meal.category
        mealDictionnary["nbGuests"] = meal.nbGuests
        
        var stagesDictionnary: [[String : Any]] = []
        meal.stageList.forEach { stage in
            var stageDictionnary: [String : Any] = [String : Any]()
            stageDictionnary["name"] = stage.name
            stageDictionnary["description"] = stage.description
            stageDictionnary["duration"] = stage.duration
            
            var ingredientsDictionnary: [[String : Any]] = []
            stage.ingredients.forEach { ingredient in
                var ingredientDictionnary: [String : Any] = [String : Any]()
                ingredientDictionnary["name"] = ingredient.name
                ingredientDictionnary["quantity"] = ingredient.quantity
                ingredientDictionnary["unit"] = ingredient.unit
                ingredientsDictionnary.append(ingredientDictionnary)
            }
            stageDictionnary["ingredients"] = ingredientsDictionnary
            stagesDictionnary.append(stageDictionnary)
        }
        mealDictionnary["stageList"] = stagesDictionnary
        return mealDictionnary
    }
    
    func updateOrAddMeal(meal: MealDTO) {
        let mealDictionnary = mealToJson(meal: meal)
        if let documentId = meal.id {
            do {
                try firestore.collection("Meals").document(documentId).setData(mealDictionnary)
            }
            catch {
              print(error)
            }
        }
        else {
            firestore.collection("Meals").addDocument(data: mealDictionnary)
        }
    }
    
    func deleteMeal(meal: MealDTO) {
        if let documentId = meal.id {
            do {
                try firestore.collection("Meals").document(documentId).delete()
            }
            catch {
              print(error)
            }
        }
    }
}
