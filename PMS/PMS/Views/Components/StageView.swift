import SwiftUI

struct StageView: View {
    @StateObject var stage: StageDTO
    @StateObject var vm: StagePageVM
    @State var stageIndex : Int
    var editable : Bool 
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("Etape n°\(stageIndex + 1)").font(.headline)
            TextField("Intitulé", text: $stage.name).font(.title3).disabled(!editable)
            HStack() {
                Text("Ingrédients").font(.headline)
                Spacer()
                Button(action: {
                    vm.ingredients.append(IngredientQuantityDTO(quantity: 0, id: "", name: "ss", isAllergern: false, category: "", price: "", unit: "", stock: 0, allergenCategory: ""))
                }) {
                    Image(systemName: "pencil.tip.crop.circle.badge.plus").imageScale(.large).foregroundColor(.accentColor)
                }.isHidden(!editable)
            }
            VStack(alignment: .leading, spacing: 2) {
                if vm.ingredients.count != 0 && editable {
                    ForEach(vm.ingredients, id: \.id) { ingredient in
                        IngredientSelectorView(ingredientSelected: ingredient).padding(.horizontal)
                    }
                }
                else if stage.ingredients.count != 0 && !editable {
                    ForEach(stage.ingredients, id: \.id) { ingredient in
                        HStack() {
                            Text(ingredient.name)
                            Spacer()
                            Text(String(ingredient.quantity) + " " + ingredient.unit)
                        }
                    }
                }
                else {
                    HStack() {
                        Spacer()
                        Text("Aucun ingrédient pour cette étape")
                        Spacer()
                    }
                }
            }.padding().overlay(RoundedRectangle(cornerRadius: 8).stroke(Color.black, lineWidth: 2))
            Text("Description").font(.headline)
            HStack() {
                if editable {
                    TextEditor(text: $stage.description).frame(height: 200)
                }
                else {
                    if let duration = stage.duration {
                        Text(stage.description + " (\(duration)\")")
                    }
                    else {
                        Text(stage.description + (" (temps indeterminé)"))
                    }
                }
                Spacer()
            }.padding().frame(maxWidth: .infinity).overlay(RoundedRectangle(cornerRadius: 8).stroke(Color.black, lineWidth: 2))
            Text("Durée (en minutes)").font(.headline).isHidden(!editable)
            HStack() {
                TextField("15", value: $stage.duration, formatter: NumberFormatter())
            }.padding().frame(maxWidth: .infinity).overlay(RoundedRectangle(cornerRadius: 8).stroke(Color.black, lineWidth: 2)).isHidden(!editable)
            Spacer()
        }.padding(.horizontal)
    }
}

extension View {
    @ViewBuilder func isHidden(_ hidden: Bool) -> some View {
        if hidden {
            self.hidden()
        }
        else {
            self
        }
    }
}
