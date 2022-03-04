import Foundation
import Combine


class StagePageVM : StageDelegeateProtocol, ObservableObject {
    var objectWillChange = PassthroughSubject<Void, Never>()
    var stage: StageDTO
    
    init(stage: StageDTO) {
        self.stage = stage
        self.ingredients = stage.ingredients
        self.stage.delegate = self
    }
    
    @Published var ingredients: [IngredientQuantityDTO] {
        willSet {
            self.objectWillChange.send()
        }
        didSet {
            if self.ingredients != self.stage.ingredients {
                self.stage.ingredients = self.ingredients
                if self.ingredients != self.stage.ingredients {
                    self.ingredients = self.stage.ingredients
                }
            }
        }
    }
    
    func change(ingredients: [IngredientQuantityDTO]) { 
        self.ingredients = ingredients
    }
}

protocol StageDelegeateProtocol {
    func change(ingredients: [IngredientQuantityDTO])
}
