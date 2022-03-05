import SwiftUI
import FirebaseFirestoreSwift
 
struct StockPage: View {
    
    @StateObject var vm = IngredientsVM()
    @State var searchText = ""
    @State var ingredients : [IngredientDTO] = []
    @State var isPlusClicked = false
    @State var sortedType = -1
    @State var stockASC : [IngredientDTO] = []
    @State var stockDSC : [IngredientDTO] = []
    @State var allergUniq : [IngredientDTO] = []
    
    @FirestoreQuery(
    collectionPath: "Ingredients",
    predicates: [.order(by: "stock", descending: false)]
    ) var queryStockASC : [IngredientDTO]
    
    @FirestoreQuery(
    collectionPath: "Ingredients",
    predicates: [.order(by: "stock", descending: true)]
    ) var queryStockDSC : [IngredientDTO]
    
    @FirestoreQuery(
    collectionPath: "Ingredients",
    predicates: [.whereField("isAllergen", isEqualTo: true)]
    ) var queryAllergen : [IngredientDTO]
    
    
    var body: some View {
        NavigationView{
            List() {
                if(sortedType == -1){
                    ForEach($ingredients, id : \.id) { ing in
                        NavigationLink(destination : DetailledStockPage(ingredient: ing.wrappedValue)){
                            ShortIngredientView(ingredient: ing)
                        }
                    }
                }
                else if(sortedType == 1){
                    ForEach($stockASC, id : \.id) { ing in
                        NavigationLink(destination : DetailledStockPage(ingredient: ing.wrappedValue)){
                            ShortIngredientView(ingredient: ing)
                        }
                    }
                }
                else if(sortedType == 2){
                    ForEach($stockDSC, id : \.id) { ing in
                        NavigationLink(destination : DetailledStockPage(ingredient: ing.wrappedValue)){
                            ShortIngredientView(ingredient: ing)
                        }
                    }
                }
                else if(sortedType == 3){
                    ForEach($allergUniq, id : \.id) { ing in
                        NavigationLink(destination : DetailledStockPage(ingredient: ing.wrappedValue)){
                            ShortIngredientView(ingredient: ing)
                        }
                    }
                }
            }.navigationBarTitle("Vos ingrédients", displayMode : .inline)
                .toolbar{
                    ToolbarItem(placement: .navigationBarLeading){
                        Menu(content : {
                            Picker(selection: $sortedType, label : Text("Trier par")) {
                                    Text(" --").tag(-1)
                                    Text("Stock croissant").tag(1)
                                    Text("Stock décroissant").tag(2)
                                    Text("Allergènes uniquement").tag(3)
                            }
                            .clipped()
                        }, label : {
                            Text("Trier par")
                        })
                    }
                    ToolbarItem(placement: .navigationBarTrailing){
                        NavigationLink(destination : NewIngredientPage(shouldPopToRootView: $isPlusClicked), isActive: $isPlusClicked) {
                            Button(action : {
                                isPlusClicked = true
                            }){
                                Image(systemName: "plus")
                            }
                        }
                    }
                }
        }.task {
            ingredients = vm.ingredients
            stockASC = queryStockASC
            stockDSC = queryStockDSC
            allergUniq = queryAllergen
        }
        .searchable(text: $searchText, placement: .automatic, prompt: "Rechercher un ingrédient, une catégorie...")
        .onChange(of: searchText) { searchText in
            if !searchText.isEmpty {
                if(sortedType == -1) {
                    ingredients = vm.ingredients.filter { $0.name.contains(searchText) ||
                        $0.unit.contains(searchText) ||  $0.price.contains(searchText) ||  $0.category.contains(searchText)}
                }
                else if(sortedType == 1){
                    stockASC = queryStockASC.filter { $0.name.contains(searchText) ||
                        $0.unit.contains(searchText) ||  $0.price.contains(searchText) ||  $0.category.contains(searchText)}
                }
                else if(sortedType == 2){
                    stockDSC = queryStockDSC.filter { $0.name.contains(searchText) ||
                        $0.unit.contains(searchText) ||  $0.price.contains(searchText) ||  $0.category.contains(searchText)}
                }
                
                else if(sortedType == 3){
                    allergUniq = queryAllergen.filter { $0.name.contains(searchText) ||
                        $0.unit.contains(searchText) ||  $0.price.contains(searchText) ||  $0.category.contains(searchText)}
                }
            }
            else {
                ingredients = vm.ingredients
                stockASC = queryStockASC
                stockDSC = queryStockDSC
                allergUniq = queryAllergen
            }
        }
    }
}


