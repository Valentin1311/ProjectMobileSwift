import Foundation

class NewIngredientVM : ObservableObject, ingredientDelegate {
    
    private var newIngredient : IngredientDTO
    private var ingredientDAO = IngredientDAO()
    
    @Published var name : String {
        didSet{
            newIngredient.name = name
        }
    }
    @Published var isAllergen : Bool {
        didSet{
            newIngredient.isAllergen = isAllergen
        }
    }
    @Published var category : String {
        didSet{
            newIngredient.category = category
        }
    }
    @Published var price : String {
        didSet{
            newIngredient.price = price
        }
    }
    @Published var unit : String {
        didSet{
            newIngredient.unit = unit
        }
    }
    @Published var stock : Double {
        didSet{
            newIngredient.stock = stock
        }
    }
    @Published var allergenCategory : String? {
        didSet{
            newIngredient.allergenCategory = allergenCategory
        }
    }
    
    init(){
        newIngredient = IngredientDTO(id: nil, name: "", isAllergen: false, category: "Viandes et Volailles", price: "", unit: "", stock: 0, allergenCategory: nil)
        name = newIngredient.name
        isAllergen = newIngredient.isAllergen
        category = newIngredient.category
        price = newIngredient.price
        unit = newIngredient.unit
        stock = newIngredient.stock
        allergenCategory = newIngredient.allergenCategory
        newIngredient.delegate = self
    }
    
    func userConfirmed() throws {
        if(isAllergen) {
            guard !name.isEmpty && !unit.isEmpty && !price.isEmpty && !allergenCategory!.isEmpty else {
                throw ingredientErrors.voidInputs
            }
        }
        else {
            guard !name.isEmpty && !unit.isEmpty && !price.isEmpty else {
                throw ingredientErrors.voidInputs
            }
        }
        ingredientDAO.updateOrAddIngredient(ing: newIngredient)
        resetIngredient()
    }
    
    func nameChanged(name: String) {
        
    }
    
    func categoryChanged(category: String) {
        
    }
    
    func unitChanged(unit: String) {
        
    }
    
    func priceChanged(price: String) {
        
    }
    
    func stockChanged(stock: Double) {
        
    }
    
    func isAllergenChanged(isAllergen: Bool) {
        if(isAllergen != self.isAllergen){
        }
    }
    
    func allergenCategoryChanged(allergenCategory: String?) {
        if(allergenCategory != self.allergenCategory){
            self.allergenCategory = allergenCategory
        }
    }
    
    func resetIngredient() {
        name = ""
        isAllergen = false
        category = "Viandes et Volailles"
        price = ""
        unit = ""
        stock = 0
        allergenCategory = nil
    }
}
