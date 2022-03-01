import SwiftUI

struct HomePage: View {
    @StateObject var vm = MealVM()
    var body: some View {
        NavigationView() {
            List() {
                ForEach($vm.meals, id: \.id) { $meal in
                    NavigationLink(destination: MealPage(meal: $meal)) {
                        Text(meal.name)
                    }.navigationBarTitle("Fiches techniques", displayMode: .inline)
                }.onDelete(perform: delete)
            }.toolbar { EditButton() }
        }
    }
    
    func delete(at offsets: IndexSet) {
        offsets.forEach { (i) in
            MealDAO().deleteMeal(meal: vm.meals[i])
        }
    }
} 
