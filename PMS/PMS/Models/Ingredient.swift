import Foundation

class IngredientDTO : Identifiable, ObservableObject, Equatable, Decodable {
    
    var delegate : ingredientDelegate?
   
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
            delegate?.isAllergenChanged(isAllergen: self.isAllergen)
        }
    }
    
    var category: String {
        didSet{
            delegate?.categoryChanged(category: self.category)
        }
    }
    
    var price: String {
        didSet{
            delegate?.priceChanged(price: self.price)
        }
    }
    
    var unit: String {
        didSet{
            delegate?.unitChanged(unit: self.unit)
        }
    }
    
    var stock : Double {
        didSet{
            delegate?.stockChanged(stock: self.stock)
        }
    }
    
    var allergenCategory: String? {
        didSet {
            delegate?.allergenCategoryChanged(allergenCategory: self.allergenCategory)
        }
    }
    
    
    
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
