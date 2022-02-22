import SwiftUI

struct ContentView: View {
    @StateObject var vm = IngredientsVM()
    @StateObject var vm2 = MealVM()
    var body: some View {
        List {
            ForEach($vm2.meals, id: \.id) { $meal in
                ForEach($meal.stageList, id: \.name) { $stg in
                    Text(stg.description)
                }
            }
        }
    }
}
