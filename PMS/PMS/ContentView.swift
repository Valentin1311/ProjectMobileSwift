import SwiftUI

struct ContentView: View { 
    var body: some View {
        TabView {
            HomePage().tabItem {
                Label("Accueil", systemImage: "house")
            }
            NewFichePage().tabItem {
                Label("Accueil", systemImage: "doc.badge.plus")
            }
            StockPage().tabItem {
                Label("Accueil", systemImage: "bag")
            }
        }
    }
}
