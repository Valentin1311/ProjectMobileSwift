import Foundation
import SwiftUI
import FirebaseFirestoreSwift

class ModifIngredientVM : ObservableObject, ingredientDelegate {
    
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
    
    init(ingredient : IngredientDTO){
        newIngredient = ingredient
        name = newIngredient.name
        isAllergen = newIngredient.isAllergen
        category = newIngredient.category
        price = newIngredient.price
        unit = newIngredient.unit
        stock = newIngredient.stock
        allergenCategory = newIngredient.allergenCategory
        newIngredient.delegate = self
    }
    
    func allFieldsAreValid() -> Bool {
        return nameValid() && unitValid() && priceValid() && allergenCategoryValid()
    }
    
    func nameValid() -> Bool {
        var test = Int(self.name)
        if(self.name.count > 0 && test == nil){
            return true
        }
        return false
    }
    
    func unitValid() -> Bool {
        var test = Int(self.unit)
        if(self.unit.count > 0 && test == nil){
            return true
        }
        return false
    }
    
    func priceValid() -> Bool {
        if(self.price.count > 1 && self.price.contains("€")){
            return true
        }
        return false
    }
    
    func allergenCategoryValid() -> Bool {
        if(self.isAllergen == true){
            var test = Int(self.allergenCategory!)
            if(self.allergenCategory!.count > 0 && test == nil){
                return true
            }
            return false
        }
        else{
            return true
        }
    }

    
    func nameChanged(name: String) {
        if(name != self.name){
            self.name = name
        }
    }
    
    func categoryChanged(category: String) {
        if(category != self.category){
            self.category = category
        }
    }
    
    func unitChanged(unit: String) {
        if(unit != self.unit){
            self.unit = unit
        }
    }
    
    func priceChanged(price: String) {
        if(price != self.price){
            self.price = price
        }
    }
    
    func stockChanged(stock: Double) {
        if(stock != self.stock){
            self.stock = stock
        }
    }
    
    func isAllergenChanged(isAllergen: Bool) {
        if(isAllergen != self.isAllergen){
            self.isAllergen = isAllergen
        }
    }
    
    func allergenCategoryChanged(allergenCategory: String?) {
        if(allergenCategory != self.allergenCategory){
            self.allergenCategory = allergenCategory
        }
    }
    
    func userConfirmed() {
        self.ingredientDAO.updateOrAddIngredient(ing: self.newIngredient)
    }
    
    func userDeleteConfirmed() {
        self.ingredientDAO.deleteIngredient(ing: self.newIngredient)
    }
    
    func resetIngredient(ingredient : IngredientDTO) {
    }
    
}
