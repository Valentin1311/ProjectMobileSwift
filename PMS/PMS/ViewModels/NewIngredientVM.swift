import Foundation

class NewIngredientVM : ObservableObject {
    
    var ingredientDAO = IngredientDAO()
    @Published var newIngredient = IngredientDTO(id: nil, name: "", isAllergern: false, category: "", price: "", unit: "", stock: 0, allergenCategory: nil)
    
    func ingredientSubmited() {
        
    }
    
    func resetIngredient() {
        newIngredient = IngredientDTO(id: nil, name: "", isAllergern: false, category: "", price: "", unit: "", stock: 0, allergenCategory: nil)
    }
}

