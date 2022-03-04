import SwiftUI

struct HomePage: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @StateObject var vm = HomePageVM()
    @State var searchText = ""
    @State var showConfirmAlert = false
    @State private var deleteIndexSet: IndexSet?
    @State var editable: Bool
    @Binding var existingMealSelected: MealDTO?
    
    var body: some View {
        if editable { NavigationView() { list }}
        else { list }
    }
    
    var list: some View {
        List() {
            ForEach($vm.filteredMeals, id: \.id) { $meal in
                if editable {
                    NavigationLink(destination: MealPage(meal: $meal)) {
                        VStack(alignment: .leading) {
                            HStack(spacing: 4) {
                                Text(meal.name).lineLimit(1).truncationMode(.tail)
                                Text("(\(meal.category))").bold().lineLimit(1).truncationMode(.tail)
                            }
                            Text(meal.manager).italic().font(.caption)
                        }
                    }.navigationBarTitle("Fiches techniques", displayMode: .inline)
                }
                else {
                    Button(action: {
                        existingMealSelected = meal
                        self.presentationMode.wrappedValue.dismiss()
                    }) {
                        VStack(alignment: .leading) {
                            HStack(spacing: 4) {
                                Text(meal.name).lineLimit(1).truncationMode(.tail)
                                Text("(\(meal.category))").bold().lineLimit(1).truncationMode(.tail)
                            }
                            Text(meal.manager).italic().font(.caption)
                        }
                    }
                }
            }.onDelete(perform: { indexSet in
                self.showConfirmAlert = true
                self.deleteIndexSet = indexSet
            }).alert("Êtes-vous sûr de vouloir supprimer cette étape", isPresented: $showConfirmAlert) {
                Button("Oui") {
                    if let set = deleteIndexSet { self.delete(at: set) }
                }
                Button("Non") {}
            }
        }.toolbar { if editable { EditButton() }}
        .searchable(text: $searchText, placement: .automatic, prompt: "Rechercher une fiche par nom, catégorie...")
        .onChange(of: searchText) { searchText in
            if !searchText.isEmpty {
                vm.filteredMeals = vm.meals.filter { $0.name.contains(searchText) ||  $0.category.contains(searchText) || $0.manager.contains(searchText) || $0.nbGuests == Int(searchText) }
            } else {
                vm.filteredMeals = vm.meals
            }
        }
    }
    
    func delete(at offsets: IndexSet) {
        offsets.forEach { (i) in
            MealDAO().deleteMeal(meal: vm.meals[i])
        }
    }
} 
