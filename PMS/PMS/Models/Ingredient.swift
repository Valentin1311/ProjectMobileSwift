import Foundation

class IngredientDTO : Identifiable, ObservableObject, Equatable, Decodable {
   
    var id: String?
    var name: String {
        didSet{
            delegate?.nameChanged(name: self.name)
        }
    }
    var isAllergen: Bool {
        didSet{
            if (isAllergen == false) {
                allergenCategory = nil
            }
            else if (isAllergen == true) {
                allergenCategory = ""
            }
            delegate?.isAllergenChanged(isAllergen: isAllergen)
        }
    }
    var category: String
    var price: String
    var unit: String
    var stock : Double
    var allergenCategory: String? {
        didSet {
            delegate?.allergenCategoryChanged(allergenCategory: allergenCategory)
        }
    }
    var delegate : ingredientDelegate?
    
    init(id: String?, name: String, isAllergen: Bool, category: String, price: String, unit: String, stock: Double, allergenCategory: String?) {
        self.id = id
        self.name = name
        self.isAllergen = isAllergen
        self.category = category
        self.price = price
        self.unit = unit
        self.stock = stock
        self.allergenCategory = allergenCategory
    }
    
    enum CodingKeys: String, CodingKey {
            case id = "id"
            case name = "name"
            case isAllergen = "isAllergen"
            case category = "category"
            case price = "price"
            case unit = "unit"
            case stock = "stock"
            case allergenCategory = "allergenCategory"
    }
    
    static func == (lhs: IngredientDTO, rhs: IngredientDTO) -> Bool {
        return lhs.id == rhs.id && lhs.name == rhs.name && lhs.isAllergen == rhs.isAllergen && lhs.category == rhs.category
        && lhs.price == rhs.price && lhs.unit == rhs.unit && lhs.stock == rhs.stock && lhs.allergenCategory == rhs.allergenCategory
    }
}
