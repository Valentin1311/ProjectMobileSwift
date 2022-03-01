import SwiftUI

struct NewIngredientPage: View {
    @StateObject var vm = NewIngredientVM()
    @State var showAlert = false
    let cols = [GridItem](repeating: .init(.flexible(), alignment: .leading), count: 2)
    let formatter : NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        return formatter
    }()
    let customBlue = Color(red: 5/255, green: 105/255, blue: 164/255)
    
    var allergenBinding: Binding<String> {
            Binding<String>(
                get: {
                    return self.vm.newIngredient.allergenCategory ?? ""
            },
                set: { newString in
                    self.vm.newIngredient.allergenCategory = newString
            })
        }
    
    var body: some View {
        ScrollView{
            VStack{
                Text("Nouvel ingrédient").frame(maxWidth : .infinity, minHeight : 35)
                    .font(.system(size : 20)).cornerRadius(20)
                    .overlay(
                        RoundedRectangle(cornerRadius: 20)
                        .stroke(customBlue, lineWidth: 1))
                    .background(.white).foregroundColor(customBlue)
                Spacer().frame(height : 40)
                LazyVGrid(columns: cols, spacing: 10) {
                    Text("Nom :")
                    TextField("", text : $vm.newIngredient.name).textFieldStyle(.roundedBorder)
                    Text("Catégorie :")
                    Picker("pickerType", selection: $vm.newIngredient.category){
                        Text("Viandes et Volailles").tag("Viandes et Volailles")
                        Text("Epicerie").tag("Epicerie")
                        Text("Fruits et Légumes").tag("Fruits et Legumes")
                        Text("Crèmerie").tag("Cremerie")
                        Text("Poissons et Crustacés").tag("Poissons et Crustaces")
                    }.onChange(of: vm.newIngredient.category, perform: { value in
                        
                    })
                    Text("Unité :")
                    TextField("", text : $vm.newIngredient.unit).textFieldStyle(.roundedBorder)
                    Text("Prix unitaire :")
                    TextField("", text : $vm.newIngredient.price).textFieldStyle(.roundedBorder)
                    Text("Stock actuel :")
                    TextField("", value : $vm.newIngredient.stock, formatter : formatter).textFieldStyle(.roundedBorder)
                }.padding(20)
                .overlay(
                    RoundedRectangle(cornerRadius: 20)
                    .stroke(customBlue, lineWidth: 1))
                Spacer().frame(height : 40)
                LazyVGrid(columns: cols, spacing: 10){
                    Text("Présence d'allergène(s) :")
                    Picker("pickerType", selection: $vm.newIngredient.isAllergen){
                        Text("Oui").tag(true)
                        Text("Non").tag(false)
                    }
                    if(vm.newIngredient.isAllergen == true) {
                        Text("Catégorie d'allergène :")
                        TextField("", text : allergenBinding).textFieldStyle(.roundedBorder).onSubmit {
                            print(vm.newIngredient.allergenCategory!)
                        }
                    }
                }.padding(20)
                .overlay(
                    RoundedRectangle(cornerRadius: 20)
                    .stroke(customBlue, lineWidth: 1))
                Spacer().frame(height : 65)
                HStack{
                    Button(action : {
                        vm.resetIngredient()
                    }){
                        Image(systemName: "arrow.clockwise").font(.system(size : 35))
                    }
                    Spacer().frame(width : 50)
                    Button(action : {
                        vm.ingredientSubmited()
                    }){
                        Image(systemName: "checkmark.circle.fill").font(.system(size : 35))
                    }
                }
                Spacer()
            }.padding(15)
        
        }
    }
}
