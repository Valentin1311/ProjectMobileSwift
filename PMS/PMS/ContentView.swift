import SwiftUI

struct ContentView: View {
    @StateObject var vm = IngredientsVM()
    @State var ingredients = []
    var body: some View {
        Text("Test")
        List {
            ForEach($vm.ingredients, id: \.id) { $ingredient in
                Text(ingredient.name)
            }
        }
    }
}
