import SwiftUI

struct DetailledStockPage: View {
    @StateObject var vm = IngredientsVM()
    @Binding var ingredient : IngredientDTO
    var body: some View {
        Text("Vous avez choisi : "+ingredient.name)
    }
}
