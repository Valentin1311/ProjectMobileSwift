import Foundation

class Category : Identifiable {
    let id  = UUID()
    var name : String
    var ingredients : [IngredientDTO]
    
    init(name :String, ingredients : [IngredientDTO]) {
        self.name = name
        self.ingredients = ingredients
    }
}
