import SwiftUI

struct ContentView: View { 
    var body: some View {
        TabView {
            HomePage().tabItem {
                Label("Accueil", systemImage: "house")
            }
            NewFichePage().tabItem {
                Label("Créer", systemImage: "doc.badge.plus")
            }
            StockPage().tabItem {
                Label("Stock", systemImage: "bag")
            } 
        }.background(.red)
    }
}
