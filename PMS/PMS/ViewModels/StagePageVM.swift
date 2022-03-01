import Foundation
import Combine


class StagePageVM : ObservableObject {
    var objectWillChange = PassthroughSubject<Void, Never>()
    var ingredients: [IngredientQuantityDTO] = [] {
        willSet {
            self.objectWillChange.send()
        }
    }
}
