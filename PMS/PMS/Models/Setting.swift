import Foundation

class SettingDTO : Identifiable, ObservableObject, Decodable {
    
    var delegate : SettingDelegate?
    
    var id : String?
    
    var name : String
    
    var value : Double{
        didSet{
            delegate?.valueChanged(newValue : value)
        }
    }
    
    init(id : String?, name : String, value : Double){
        self.id = id
        self.name = name
        self.value = value
    }
    
    enum CodingKeys: String, CodingKey {
            case id = "id"
            case name = "name"
            case value = "value"
    }
    
}
