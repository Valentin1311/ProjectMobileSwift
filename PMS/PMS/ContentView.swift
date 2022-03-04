import SwiftUI

struct ContentView: View {
    @State private var mainPageIndex = 0
    @State var meal: MealDTO? = nil
    var body: some View {
        TabView(selection: $mainPageIndex) {
            HomePage(editable: true, existingMealSelected: $meal).tabItem {
                Label("Accueil", systemImage: "house")
            }.tag(0)
            NewFichePage(mainPageIndex: $mainPageIndex).tabItem {
                Label("Créer", systemImage: "doc.badge.plus")
            }.tag(1)
            StockPage().tabItem {
                Label("Stock", systemImage: "bag")
            }.tag(2) 
        }.background(.red)
    }
}
