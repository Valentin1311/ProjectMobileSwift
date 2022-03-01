import Foundation

class StageDTO : Identifiable, ObservableObject, Hashable {
    static func == (lhs: StageDTO, rhs: StageDTO) -> Bool {
        return lhs.name == rhs.name && lhs.description == rhs.description && lhs.ingredients == rhs.ingredients && lhs.duration == rhs.duration
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(name)
    }
    
    var name : String
    var description : String
    var ingredients : [IngredientQuantityDTO]
    var duration : String?
    
    init(name : String, description : String, ingredients : [IngredientQuantityDTO], duration : String?){
        self.name = name
        self.description = description
        self.ingredients = ingredients
        self.duration = duration
    }
}
