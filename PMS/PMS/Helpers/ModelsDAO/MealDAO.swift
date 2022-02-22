import Foundation
import FirebaseFirestore

class MealDAO {
    
    func mapMeals(documents : [QueryDocumentSnapshot]) -> [MealDTO]{
        return documents.map {(doc) -> MealDTO in
                return MealDTO(id: doc.documentID, name: doc["name"] as? String ?? "", manager: doc["manager"] as? String ?? "", category: doc["category"] as? String ?? "",
                               nbGuests: doc["nbGuests"] as? Int ?? 1, stageList: (doc["stageList"] as! [[String : AnyObject]]).map{
                    (doc) -> StageDTO in
                    return self.jsonToStage(doc : doc)
                }, matS: doc["matS"] as? String ?? "", matD: doc["matD"] as? String ?? "", coefVenteHT: doc["coefVenteHT"] as? String ?? "", coefVenteTTC: doc["coefVenteTTC"] as? String ?? "", coutHFluide: doc["coutHFluide"] as? String ?? "", coutHMoyen: doc["coutHMoyen"] as? String ?? "")
            }
    }
    
    func jsonToStage(doc : [String : AnyObject]) -> StageDTO {
        return StageDTO(name : doc["name"] as! String, description: doc["description"] as! String, ingredients: doc["ingredients"] as? [[String : String]] ?? nil, duration: doc["duration"] as? String ?? nil)
    }
    
}
