import SwiftUI

struct SellSheetView: View {
    
    @Environment(\.dismiss) var dismiss
    
    @StateObject var ingVM = IngredientsVM()
    @State var meal : MealDTO
    @State var numberOfMealSelled : Int = 0
    @State var showConfirm = false
    @State var showValidation = false
    
    var ingDAO = IngredientDAO()
    
    let formatter : NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        return formatter
    }()
    
    let customBlue = Color(red: 5/255, green: 105/255, blue: 164/255)
    
    var body: some View {
        VStack(alignment : .center){
            Spacer()
            Text("Déclaration d'une vente de :").font(.title2).foregroundColor(customBlue).multilineTextAlignment(.center)
            Spacer().frame(height : 30)
            TextField("11", value : $numberOfMealSelled, formatter: formatter).frame(width : 100, height: 50)
                .textFieldStyle(PlainTextFieldStyle())
                .cornerRadius(10)
                .overlay(RoundedRectangle(cornerRadius: 10).stroke(customBlue))
                .multilineTextAlignment(.center)
            Spacer().frame(height : 30)
            Text("\(meal.name)").bold().font(.title2).foregroundColor(customBlue).multilineTextAlignment(.center)
            Spacer().frame(height : 40)
            Button(action : {
                showConfirm = true
            })
            {
                HStack{
                    Image(systemName: "banknote").imageScale(.large)
                    Text("Vendre").font(.headline)
                }
                    .frame(width : 140, height : 50)
            }.buttonStyle(PlainButtonStyle())
                .background(customBlue)
                 .foregroundColor(Color.white)
                 .cornerRadius(15)
                 .overlay(RoundedRectangle(cornerRadius: 15).stroke(customBlue))
            Spacer()
            Button("Fermer la fenêtre"){ dismiss() }
        }.confirmationDialog("Êtes-vous sûr de vouloir déclarer la vente de \(numberOfMealSelled) \(meal.name) ?", isPresented: $showConfirm, titleVisibility: .visible){
            Button("Oui"){
                vente()
                showValidation = true
            }
            Button("Non", role: .cancel){}
        }.alert(isPresented : $showValidation) {
            Alert(title: Text("Confirmation"), message: Text("Vente déclarée avec succès !"))}
    }
    
    func vente() {
        var numberOfSelled = numberOfMealSelled
        var ingredients = ingVM.ingredients
        for stage in meal.stageList {
            for ing in stage.ingredients {
                var quantity = ing.quantity
                var name = ing.name
                var ingredientMatches = ingredients.filter{ $0.name == name }
                for match in ingredientMatches {
                    match.stock = match.stock - Double(numberOfSelled * quantity)
                    ingDAO.updateOrAddIngredient(ing: match)
                }
            }
        }
    }
}
