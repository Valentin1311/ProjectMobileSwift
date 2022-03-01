import SwiftUI

struct IngredientSelectorView: View {
    @StateObject var vmIng = IngredientsVM()
    @State private var indexIngredientSelected = 0
    @StateObject var ingredientSelected: IngredientQuantityDTO
    var cols =     [
        GridItem(.flexible(), spacing: 10, alignment: .leading),
        GridItem(.flexible(), spacing: 10, alignment: .leading),
        GridItem(.flexible(), spacing: 10, alignment: .trailing)
    ]
    var numberFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.zeroSymbol = ""
        return formatter
    }()
    var body: some View {
        LazyVGrid(columns : cols, alignment: .center, spacing: 0) {
            TextField("12", value: $ingredientSelected.quantity, formatter: numberFormatter).frame(width: 100)
            Text(vmIng.ingredients.count != 0 ? vmIng.ingredients[indexIngredientSelected].unit : "")
            Picker("Ingrédients", selection: $indexIngredientSelected) {
                ForEach($vmIng.ingredients, id: \.id) { $ingredient in
                    Text(ingredient.name)
                }
            }.onChange(of: ingredientSelected) { tag in
                print("ingredient selected : \(tag.name)")
            }.id(UUID())
        }
    }
}  
