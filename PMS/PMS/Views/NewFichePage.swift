import SwiftUI

struct NewFichePage: View {
    @State private var index = 0
    @State var meal: MealDTO = MealDTO(id: nil, name: "", manager: "", category: "", nbGuests: 0, stageList: [StageDTO(name: "", description: "", ingredients: nil, duration: nil)], matS: nil, matD: nil, coefVenteHT: nil, coefVenteTTC: nil, coutHFluide: nil, coutHMoyen: nil)
    @State private var selectedCategory: Categories = .entree
    var body: some View {
        VStack() {
            NavigationView() {
                TabView(selection: $index) {
                    VStack() {
                        Text("Intitulé")
                        TextField("Boeuf bourgignon", text: $meal.name)
                        Text("Catégorie")
                        List {
                            Picker("Catégories", selection: $selectedCategory) {
                                Text("Entrée").tag(Categories.entree)
                                Text("Plat").tag(Categories.plat)
                                Text("Dessert").tag(Categories.dessert)
                            }
                        }
                        Text("Nombre de couverts")
                        TextField("Intitulé", value: $meal.nbGuests, formatter: NumberFormatter())
                        Text("Responsable")
                        TextField("Jean JACQUES", text: $meal.manager)
                    }
                    VStack() {
                        
                    }
                 }
                 .tabViewStyle(PageTabViewStyle(indexDisplayMode: .always))
            }
            TabView(selection: $index) {
                ForEach((0..<meal.stageList.count), id: \.self) { index in
                    StageView(stage: meal.stageList[index], editable: true)
                 }
             }
             .tabViewStyle(PageTabViewStyle(indexDisplayMode: .always))
        }
    }
} 

enum Categories: String, CaseIterable, Identifiable {
    case entree, plat, dessert
    var id: Self { self }
}
