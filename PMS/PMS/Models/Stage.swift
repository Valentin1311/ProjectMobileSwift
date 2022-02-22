import Foundation

class StageDTO : Identifiable {
    var name : String
    var description : String
    var ingredients : [[String : String]]?
    var duration : String?
    
    init(name : String, description : String, ingredients : [[String : String]]?, duration : String?){
        self.name = name
        self.description = description
        self.ingredients = ingredients
        self.duration = duration
    }
}
