import Foundation


class MealDTO : Identifiable, ObservableObject {
    var id: String?
    var name: String
    var manager: String
    var category: String
    var nbGuests: Int
    var stageList: [StageDTO]
    var matS: String?
    var matD: String?
    var coefVenteHT: Int?
    var coefVenteTTC: Int?
    var coutHFluide: Int?
    var coutHMoyen: Int?
    
    var hasNoIngredients : Bool {
        var count = 0
        for stage in stageList {
            for ing in stage.ingredients {
                count += 1
            }
        }
        if(count == 0){
            return true
        }
        return false
    }
    
    var allergenIngredients : [String]{
        var allergens : [String] = []
        for stage in stageList {
            for ing in stage.ingredients {
                
            }
        }
        return allergens
    }
    
    var uniqueIngredients : [String] {
        var uniqs : [String] = []
        for stage in stageList {
            for ing in stage.ingredients {
                if(uniqs.contains(ing.name)){ }
                else{
                    uniqs.append(ing.name)
                }
            }
        }
        return uniqs
    }

    init(id:String?, name: String, manager: String, category: String, nbGuests: Int, stageList: [StageDTO], matS: String?, matD: String?, coefVenteHT: Int?, coefVenteTTC: Int?, coutHFluide: Int?, coutHMoyen: Int?) {
        self.id = id
        self.name = name
        self.manager = manager
        self.category = category
        self.nbGuests = nbGuests
        self.stageList = stageList
        self.matS = matS
        self.matD = matD
        self.coefVenteHT = coefVenteHT
        self.coefVenteTTC = coefVenteTTC
        self.coutHFluide = coutHFluide
        self.coutHMoyen = coutHMoyen
    }
}
