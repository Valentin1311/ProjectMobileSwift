import SwiftUI
 
struct StockPage: View {
    @StateObject var vm = IngredientsVM()
    @State var searchText = ""
    @State var ingredients : [IngredientDTO] = []
    @State var isPlusClicked = false
    
    var body: some View {
        NavigationView{
            List() {
                ForEach($ingredients, id: \.id) { ing in
                    NavigationLink(destination: DetailledStockPage(ingredient: ing)) {
                        ShortIngredientView(ingredient: ing)
                    }
                }
            }.navigationBarTitle("Vos ingrédients", displayMode : .inline)
                .toolbar{
                    NavigationLink(destination : NewIngredientPage(), isActive: $isPlusClicked) {
                        Button(action : {
                            isPlusClicked = true
                        }){
                            Image(systemName: "plus")
                        }
                    }
                }
        }
        .task {
            ingredients = vm.ingredients
        }
        .searchable(text: $searchText, placement: .automatic, prompt: "Rechercher un ingrédient, une catégorie...")
        .onChange(of: searchText) { searchText in
            if !searchText.isEmpty {
                ingredients = vm.ingredients.filter { $0.name.contains(searchText) ||  $0.category.contains(searchText)
                 ||  $0.unit.contains(searchText) ||  $0.price.contains(searchText)
                }
            } else {
               ingredients = vm.ingredients
            }
        }
    }
}


