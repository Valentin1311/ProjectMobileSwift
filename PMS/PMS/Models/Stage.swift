import Foundation

class StageDTO : Identifiable, ObservableObject, Hashable {
    var delegate: StagePageVM?
    
    var name : String
    var description : String
    var ingredients : [IngredientQuantityDTO] {
        didSet { 
            if (self.ingredients != oldValue) {
                if self.ingredients == [] {
                    self.ingredients = oldValue
                }
                else {
                    self.delegate?.change(ingredients: self.ingredients)
                }
            }
        }
    }
    var duration : String?
    
    init(name : String, description : String, ingredients : [IngredientQuantityDTO], duration : String?){
        self.name = name
        self.description = description
        self.ingredients = ingredients
        self.duration = duration
    }
    
    static func == (lhs: StageDTO, rhs: StageDTO) -> Bool {
        return lhs.name == rhs.name && lhs.description == rhs.description && lhs.ingredients == rhs.ingredients && lhs.duration == rhs.duration
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(name)
    }
}
