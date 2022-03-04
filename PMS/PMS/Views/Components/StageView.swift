import SwiftUI

struct StageView: View {
    @StateObject var vm: StagePageVM
    @State var stageIndex : Int
    var editable : Bool 
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 10) {
                Text("Etape n°\(stageIndex + 1)" + (editable ? " *" : "")).font(.headline)
                TextField("Boeuf bourgignon", text: $vm.stage.name).disabled(!editable).padding().overlay(RoundedRectangle(cornerRadius: 8).stroke(Color.black, lineWidth: 2))
                HStack() {
                    Text("Ingrédients").font(.headline)
                    Spacer()
                    Button(action: {
                        vm.ingredients.append(IngredientQuantityDTO(quantity: 0, id: nil, name: "", isAllergen: false, category: "", price: "", unit: "", stock: 0, allergenCategory: nil))
                    }) {
                        Image(systemName: "pencil.tip.crop.circle.badge.plus").imageScale(.large).foregroundColor(.accentColor)
                    }.isHidden(!editable)
                }
                HStack {
                    if vm.stage.ingredients.count != 0 {
                        if editable {
                            ScrollView() {
                                VStack(spacing: 10) {
                                    if editable {
                                        ForEach(Array(zip(vm.stage.ingredients.indices, vm.stage.ingredients)), id: \.0.self) { index, ingredient in
                                            IngredientSelectorView(ingredient: ingredient, indexOnVm: index, vmStage: vm)
                                        }
                                    }
                                }
                            }
                        }
                        else {
                            VStack(spacing: 5) {
                                ForEach(vm.stage.ingredients, id: \.id) { ingredient in
                                    HStack(alignment: .center, spacing: 0) {
                                        Text("• \(ingredient.quantity) \(ingredient.unit) \(ingredient.name)")
                                        Spacer()
                                    }
                                }
                            }
                        }
                    }
                    else {
                        HStack() {
                            Text("Aucun ingrédient pour cette étape")
                            Spacer()
                        }
                    }
                }.padding().overlay(RoundedRectangle(cornerRadius: 8).stroke(Color.black, lineWidth: 2))
                Text("Description" + (editable ? " *" : "")).font(.headline)
                HStack() {
                    if editable {
                        TextEditor(text: $vm.stage.description).frame(height: 170)
                    }
                    else {
                        Text(vm.stage.description)
                    }
                    Spacer()
                }.frame(maxWidth: .infinity).padding().overlay(RoundedRectangle(cornerRadius: 8).stroke(Color.black, lineWidth: 2))
                Text("Durée (en minutes)").font(.headline)
                HStack() {
                    if editable {
                        TextField("15", value: $vm.stage.duration, formatter: NumberFormatter())
                    }
                    else {
                        if vm.stage.duration != "0" && vm.stage.duration != nil {
                            Text(vm.stage.duration! + " \"")
                        }
                        else {
                            Text("Temps indeterminé")
                        }
                    }
                    Spacer()
                }.frame(maxWidth: .infinity).padding().overlay(RoundedRectangle(cornerRadius: 8).stroke(Color.black, lineWidth: 2)).padding(.bottom)
                Spacer()
            }.padding(.horizontal).padding(.bottom, 20)
        }
    }
}
