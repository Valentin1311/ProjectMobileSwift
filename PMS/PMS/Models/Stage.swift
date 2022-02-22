import Foundation

class StageDTO : Identifiable, ObservableObject {
    var name : String
    var description : String
    var ingredients : [IngredientQuantityDTO]?
    var duration : String?
    
    init(name : String, description : String, ingredients : [IngredientQuantityDTO]?, duration : String?){
        self.name = name
        self.description = description
        self.ingredients = ingredients
        self.duration = duration
    }
}
