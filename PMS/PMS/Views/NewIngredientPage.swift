import SwiftUI

struct NewIngredientPage: View {
    
    @Binding var shouldPopToRootView : Bool
    @StateObject var vm = NewIngredientVM()
    @State var showEmptyAlert = false
    @State var showConfirm = false
    @State var showValidation = false
    
    let cols = [GridItem(.flexible(), alignment: .leading), GridItem(.fixed(200),alignment: .center)]
    let formatter : NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        return formatter
    }()
    let customBlue = Color(red: 5/255, green: 105/255, blue: 164/255)
    
    var allergenBinding: Binding<String> {
            Binding<String>(
                get: {
                    return self.vm.allergenCategory ?? ""
            },
                set: { newString in
                    self.vm.allergenCategory = newString
            })
    }
    
    var body: some View {
        ScrollView{
            VStack{
                Text("Nouvel ingrédient").frame(maxWidth : .infinity, minHeight : 35)
                    .font(.system(size : 20)).cornerRadius(0)
                    .background(.white).foregroundColor(customBlue)
                Spacer().frame(height : 10)
                LazyVGrid(columns: cols, spacing: 20) {
                    Text("Nom")
                    VStack{
                        TextField("Agar Agar", text : $vm.name)
                            .textFieldStyle(.roundedBorder).cornerRadius(5)
                            .overlay(RoundedRectangle(cornerRadius: 5).stroke(Color.black))
                        Text("Votre nom doit contenir au moins une lettre")
                            .fixedSize(horizontal: false, vertical: true)
                            .font(.caption2)
                    }
                    
                    Text("Catégorie")
                    Picker("pickerType", selection: $vm.category){
                        Text("Viandes et Volailles").tag("Viandes et Volailles")
                        Text("Epicerie").tag("Epicerie")
                        Text("Fruits et Légumes").tag("Fruits et Legumes")
                        Text("Crèmerie").tag("Cremerie")
                        Text("Poissons et Crustacés").tag("Poissons et Crustaces")
                    }
                    Text("Unité")
                    TextField("Kg", text : $vm.unit).textFieldStyle(.roundedBorder).cornerRadius(5)
                        .overlay(RoundedRectangle(cornerRadius: 5).stroke(Color.black))
                    Text("Prix unitaire")
                    TextField("11 €", text : $vm.price).textFieldStyle(.roundedBorder).cornerRadius(5)
                        .overlay(RoundedRectangle(cornerRadius: 5).stroke(Color.black))
                    Text("Stock actuel")
                    TextField("50", value : $vm.stock, formatter : formatter).textFieldStyle(.roundedBorder).cornerRadius(5)
                        .overlay(RoundedRectangle(cornerRadius: 5).stroke(Color.black))
                }.padding(20)
                .overlay(
                    RoundedRectangle(cornerRadius: 20)
                    .stroke(customBlue, lineWidth: 1))
                Spacer().frame(height : 30)
                LazyVGrid(columns: cols, spacing: 20){
                    Text("Présence d'allergène(s)")
                    Picker("pickerType", selection: $vm.isAllergen){
                        Text("Oui").tag(true)
                        Text("Non").tag(false)
                    }
                    if(vm.isAllergen == true) {
                        Text("Catégorie d'allergène")
                        TextField("Fruit à coque", text : allergenBinding).textFieldStyle(.roundedBorder).cornerRadius(5)
                            .overlay(RoundedRectangle(cornerRadius: 5).stroke(Color.black))
                            .onSubmit {
                            print(vm.allergenCategory!)
                        }
                    }
                }.padding(20)
                .overlay(
                    RoundedRectangle(cornerRadius: 20)
                    .stroke(customBlue, lineWidth: 1))
                Spacer().frame(height : 50)
                HStack{
                    Button(action : {
                        shouldPopToRootView = false
                    }){
                        Image(systemName: "arrowshape.turn.up.left").font(.system(size : 35))
                    }
                    Spacer().frame(width : 50)
                    Button(action : {
                        showConfirm = true
                    }){
                        Image(systemName: "checkmark.circle.fill").font(.system(size : 35))
                    }
                }
                Spacer()
            }.padding(15)
                .confirmationDialog("Êtes-vous sûr de vouloir créer cet ingrédient ?", isPresented: $showConfirm, titleVisibility: .visible){
                    Button("Oui"){
                        do{
                            try vm.userConfirmed()
                            showValidation = true
                        }
                        catch ingredientErrors.voidInputs {
                            showEmptyAlert = true
                        }
                        catch{
                            showEmptyAlert = true
                        }
                    }.alert(isPresented : $showEmptyAlert) {
                        Alert(title: Text("Attention"), message: Text("Vous devez remplir tous les champs"))}
                    Button("Non", role: .cancel){}
                }//.alert(isPresented : $showValidation) {
                    //Alert(title: Text("Confirmation"), message: Text("Votre ingrédient a été créé avec succès"))}
        }
    }
}
