import Foundation

protocol ingredientDelegate {
    func nameChanged(name : String)
    func categoryChanged(category : String)
    func unitChanged(unit : String)
    func priceChanged(price : String)
    func stockChanged(stock : Double)
    func isAllergenChanged(isAllergen : Bool)
    func allergenCategoryChanged(allergenCategory : String?)
}
