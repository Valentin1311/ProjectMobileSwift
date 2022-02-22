//
//  StageDAO.swift
//  PMS
//
//  Created by m1 on 22/02/2022.
//  Copyright © 2022 	. All rights reserved.
//

import Foundation
import FirebaseFirestore

class StageDAO {
    func mapStages(documents : [QueryDocumentSnapshot]) -> [StageDTO]{
        return documents.map {(doc) -> StageDTO in
            return jsonToStage(doc: doc)
        }
    }
    
    func jsonToStage(doc : QueryDocumentSnapshot) -> StageDTO {
        let ingredients = (doc["ingredients"] as! [[String : AnyObject]]).map{
            (doc) -> IngredientQuantityDTO in
            return IngredientQuantityDAO().jsonToIngredientQuantity(doc: doc)
        }
        return StageDTO(name: doc["name"] as? String ?? "", description: doc["description"] as? String ?? "",
                 ingredients: ingredients.count != 0 ? ingredients : nil, duration: doc["duration"] as? String)
    }
    
    func jsonToStage(doc : [String : AnyObject]) -> StageDTO {
        let ingredients = (doc["ingredients"] as! [[String : AnyObject]]).map{
            (doc) -> IngredientQuantityDTO in
            return IngredientQuantityDAO().jsonToIngredientQuantity(doc: doc)
        }
        return StageDTO(name: doc["name"] as? String ?? "", description: doc["description"] as? String ?? "",
                 ingredients: ingredients.count != 0 ? ingredients : nil, duration: doc["duration"] as? String)
    }
}
