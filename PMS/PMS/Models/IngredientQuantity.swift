import Foundation

class IngredientQuantityDTO : IngredientDTO {
    var quantity: Int
    init(quantity: Int?, id: String?, name: String, isAllergen: Bool, category: String, price: String, unit: String, stock: Double, allergenCategory: String?) {
        self.quantity = quantity ?? 0
        super.init(id: id, name: name, isAllergen: isAllergen, category: category, price: price, unit: unit, stock: stock, allergenCategory: allergenCategory)
    }
    
    init(quantity: Int?, ingredient: IngredientDTO) {
        self.quantity = quantity ?? 0
        super.init(id: ingredient.id, name: ingredient.name, isAllergen: ingredient.isAllergen, category: ingredient.category, price: ingredient.price, unit: ingredient.unit, stock: ingredient.stock, allergenCategory: ingredient.allergenCategory)
    }
    
    required init(from decoder: Decoder) throws {
        fatalError("init(from:) has not been implemented")
    }
    
    override func hash(into hasher: inout Hasher) {
        hasher.combine(self.id)
    }
    
    static func ==(lhs: IngredientQuantityDTO, rhs: IngredientQuantityDTO) -> Bool {
        return lhs.quantity == rhs.quantity && lhs.id == rhs.id && lhs.name == rhs.name && lhs.category == rhs.category && lhs.price == rhs.price && lhs.unit == rhs.unit && lhs.stock == rhs.stock && lhs.allergenCategory == rhs.allergenCategory
        
    }
}
