import SwiftUI
import FirebaseFirestoreSwift

struct EtiquettePreviewView: View {
    
    @StateObject var vm = MealPageVM()
    @StateObject var vmIng = IngredientsVM()
    @State var meal : MealDTO
    @State var uniqueIngredients : [String] = []
    
    @FirestoreQuery(
    collectionPath: "Ingredients",
    predicates: [.whereField("isAllergen", isEqualTo: true)]
    ) var queryAllergen : [IngredientDTO]
    
    var allergensName : [String] {
        var allergs : [String] = []
        for ing in queryAllergen {
            allergs.append(ing.name)
        }
        return allergs
    }
    
    var col :  [GridItem] = Array(repeating: .init(.flexible()), count: 3)
    
    var body: some View {
        ScrollView{
            VStack{
                VStack{
                    Text(meal.name).font(.title2).bold().multilineTextAlignment(.center)
                    Text("Étiquette").italic().font(.title3)
                    Spacer().frame(height : 2)
                }
                .frame(maxWidth : .infinity)
                .overlay(
                    RoundedRectangle(cornerRadius: 0)
                        .stroke(.black, lineWidth: 2))
                Spacer().frame(height : 20)
                if(meal.hasNoIngredients){
                    Text("Pas d'ingrédients pour ce plat").foregroundColor(.blue).font(.headline)
                    Spacer().frame(height : 20)
                }
                else{
                    LazyVGrid(columns: col, spacing: 10){
                        ForEach(meal.uniqueIngredients, id : \.self){ name in
                            if (allergensName.contains(name)){
                                Text(name).bold().multilineTextAlignment(.center).font(.system(size: 15))
                            }
                            else {
                                Text(name).multilineTextAlignment(.center).font(.system(size: 15))
                            }
                        }
                    }
                    Spacer().frame(height : 5)
                }
            }
            .overlay(
                RoundedRectangle(cornerRadius: 0)
                    .stroke(.black, lineWidth: 2))
            .toolbar {
                ToolbarItem {
                    Button(action: {
                        printEtiquette()
                    }) {
                        Image(systemName: "arrow.down.doc").imageScale(.large).foregroundColor(.accentColor)
                    }
                }
            }.sheet(isPresented: $vm.showShareSheet) {
                vm.pdfURL = nil
            } content: {
                if let pdfURL = vm.pdfURL {
                    ShareSheet(urls: [pdfURL])
                }
            }.padding(.vertical)
        }.padding(10)
    }
    func printEtiquette() {
        exportPDF(content: { self }, filename: meal.name+"_Etiquette") { status, url in
            if let url = url, status {
                vm.pdfURL = url
                vm.showShareSheet.toggle()
            }
            else {
                print("PDF failed")
            }
        }
    }
}
