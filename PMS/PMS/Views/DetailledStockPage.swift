import SwiftUI

struct DetailledStockPage: View {
    
    @ObservedObject var vm : ModifIngredientVM
    @Binding var ingredient : IngredientDTO
    @State var editClicked = false
    @State var showModifConfirm = false
    @State var showDeleteConfirm = false
    @State var showDeleteValidation = false
    @State var ingredientDeleted = false
    
    let cols = [GridItem(.flexible(), alignment: .leading), GridItem(.fixed(175),alignment: .center)]
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
            if(!ingredientDeleted){
                VStack{
                    Text("Fiche ingrédient").frame(maxWidth : .infinity, minHeight : 35)
                        .font(.system(size : 20)).cornerRadius(0)
                        .background(.white).foregroundColor(customBlue)
                    Spacer().frame(height : 10)
                    LazyVGrid(columns: cols, spacing: 20) {
                        Text("Nom")
                        VStack{
                            if(editClicked){
                                TextField("Agar Agar", text : $vm.name)
                                    .textFieldStyle(.roundedBorder).cornerRadius(5)
                                    .overlay(RoundedRectangle(cornerRadius: 5).stroke(Color.black))
                                    .disabled(!editClicked)
                            }
                            else{
                                TextField("Agar Agar", text : $vm.name)
                                    .textFieldStyle(.roundedBorder).cornerRadius(5)
                                    .disabled(!editClicked)
                            }
                            if(!vm.nameValid() && editClicked){
                                Text("Doit contenir au moins une lettre")
                                    .font(.caption2)
                                    .foregroundColor(.red)
                            }
                        }
                        Text("Catégorie")
                        Picker("pickerType", selection: $vm.category){
                            Text("Viandes et Volailles").tag("Viandes et Volailles")
                            Text("Epicerie").tag("Epicerie")
                            Text("Fruits et Légumes").tag("Fruits et Legumes")
                            Text("Crèmerie").tag("Cremerie")
                            Text("Poissons et Crustacés").tag("Poissons et Crustaces")
                        }.disabled(!editClicked)
                        Text("Unité")
                        VStack{
                            if(editClicked){
                                TextField("Kg", text : $vm.unit).textFieldStyle(.roundedBorder).cornerRadius(5)
                                    .overlay(RoundedRectangle(cornerRadius: 5).stroke(Color.black))
                                    .disabled(!editClicked)
                            }
                            else{
                                TextField("Kg", text : $vm.unit).textFieldStyle(.roundedBorder).cornerRadius(5)
                                    .disabled(!editClicked)
                            }
                            if(!vm.unitValid() && editClicked){
                                Text("Doit contenir au moins une lettre")
                                    .font(.caption2)
                                    .foregroundColor(.red)
                            }
                        }
                        Text("Prix\nunitaire")
                        VStack{
                            if(editClicked){
                                TextField("11€", text : $vm.price)
                                    .textFieldStyle(.roundedBorder).cornerRadius(5)
                                    .overlay(RoundedRectangle(cornerRadius: 5).stroke(Color.black))
                                    .disabled(!editClicked)
                            }
                            else{
                                TextField("11€", text : $vm.price)
                                    .textFieldStyle(.roundedBorder).cornerRadius(5)
                                    .disabled(!editClicked)
                            }
                            if(!vm.priceValid() && editClicked){
                                Text("Doit contenir au moins un chiffre et le signe '€'")
                                    .font(.caption2)
                                    .foregroundColor(.red)
                            }
                        }
                        Text("Stock actuel")
                        if(editClicked){
                            TextField("50", value : $vm.stock, formatter : formatter).textFieldStyle(.roundedBorder).cornerRadius(5)
                                .overlay(RoundedRectangle(cornerRadius: 5).stroke(Color.black))
                                .disabled(!editClicked)
                        }
                        else{
                            TextField("50", value : $vm.stock, formatter : formatter).textFieldStyle(.roundedBorder).cornerRadius(5)
                                .disabled(!editClicked)
                            
                        }  
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
                        }.disabled(!editClicked)
                        if(vm.isAllergen == true) {
                            Text("Catégorie d'allergène")
                            VStack{
                                if(editClicked){
                                    TextField("Fruit à coque", text : allergenBinding).textFieldStyle(.roundedBorder).cornerRadius(5)
                                        .overlay(RoundedRectangle(cornerRadius: 5).stroke(Color.black))
                                        .disabled(!editClicked)
                                }
                                else{
                                    TextField("Fruit à coque", text : allergenBinding).textFieldStyle(.roundedBorder).cornerRadius(5)
                                        .disabled(!editClicked)
                                }
                                if(!vm.allergenCategoryValid() && editClicked){
                                    Text("Doit contenir au moins une lettre")
                                        .font(.caption2)
                                        .foregroundColor(.red)
                                }
                            }
                        }
                    }.padding(20)
                    .overlay(
                        RoundedRectangle(cornerRadius: 20)
                        .stroke(customBlue, lineWidth: 1))
                    Spacer().frame(height : 50)
                    HStack{
                        if(!editClicked){
                            Button(action : {
                                showDeleteConfirm = true
                            }){
                                Image(systemName: "trash").font(.system(size : 35)).foregroundColor(.red)
                            }.confirmationDialog("Êtes-vous sûr de vouloir supprimer cet ingrédient ?", isPresented: $showDeleteConfirm, titleVisibility: .visible){
                                Button("Oui"){
                                    vm.userDeleteConfirmed()
                                    showDeleteValidation = true
                                    ingredientDeleted = true
                                }
                                Button("Non", role: .cancel){}
                            }
                            Spacer().frame(width : 40)
                            Button(action : {
                                editClicked = true
                            }){
                                Image(systemName: "pencil").font(.system(size : 35))
                            }
                        }
                        else {
                            //Button(action : {
                              //  vm.resetIngredient(ingredient: ingredient)
                                //editClicked = false
                            //}){
                              //  Image(systemName: "plus").font(.system(size : 35)).rotationEffect(.degrees(-45)).foregroundColor(.gray)
                            //}.disabled(!vm.allFieldsAreValid())
                            //Spacer().frame(width : 40)
                            Button(action : {
                                showModifConfirm = true
                            }){
                                Image(systemName: "checkmark.circle.fill").font(.system(size : 35))
                            }.disabled(!vm.allFieldsAreValid())
                                .confirmationDialog("Voulez-vous vraiment enregistrer vos modifications ?", isPresented: $showModifConfirm, titleVisibility: .visible){
                                    Button("Oui"){
                                        vm.userConfirmed()
                                        editClicked = false
                                    }
                                    Button("Non", role: .cancel){}
                                }
                        }
                    }
                    Spacer()
                }.padding(15)
            }
            
        }
        .alert(isPresented : $showDeleteValidation) {
            Alert(title: Text("Suppression effectuée"), message: Text("Veuillez revenir à l'écran principal"))}
    }
}
