import SwiftUI
import Combine

struct IngredientSelectorView: View {
    @StateObject private var vmIng: IngredientsVM = IngredientsVM()
    @State var ingredient: IngredientQuantityDTO
    @State private var indexIngredientSelected: Int = 0
    @State private var quantity: Int = 0
    @State var indexOnVm : Int
    var vmStage: StagePageVM
    var cols =     [
        GridItem(.flexible(), spacing: 10, alignment: .leading),
        GridItem(.flexible(), spacing: 10, alignment: .leading),
        GridItem(.flexible(), spacing: 10, alignment: .trailing)
    ]
    var numberFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.zeroSymbol = ""
        return formatter
    }()
    
    init(ingredient: IngredientQuantityDTO, indexOnVm: Int, vmStage: StagePageVM) {
        self.ingredient = ingredient
        self.quantity = ingredient.quantity
        self.indexOnVm = indexOnVm
        self.vmStage = vmStage
    }
    
    var body: some View {
        
        let quantityBinding = Binding<Int>(get: {
            self.quantity
        }, set: {
            self.quantity = $0
            vmStage.ingredients[indexOnVm].quantity = self.quantity
        })
        
        HStack(alignment: .center, spacing: 10) {
            VStack(spacing: 4) {
                HStack {
                    TextField(String(Int.random(in: 1..<99)), value: quantityBinding, formatter: numberFormatter).padding(.vertical, -8)
                    Text(vmIng.ingredients.count != 0 ? vmIng.ingredients[indexIngredientSelected].unit : "")
                }
                Rectangle().fill(.black).frame(width: 100, height: 1)
            }.frame(width: 100)
            Spacer()
            Picker(selection: $indexIngredientSelected, label: Text("Ingrédients")) {
                ForEach(Array(zip(vmIng.ingredients.indices, vmIng.ingredients)), id: \.0.self) { index, ingredient in
                    Text(ingredient.name)
                }
            }
            .onChange(of: indexIngredientSelected) { tag in
                onIngredientQuantityChange(tag)
            }
            .padding(.vertical, -8)
        }
        //.onAppear {
          //  if let ing = vmIng.ingredients.firstIndex(of: ingredient) {
            //    indexIngredientSelected = ing
            //}
        //}
    }
    
    func onIngredientQuantityChange(_ index: Int) {
        vmStage.ingredients[indexOnVm] = IngredientQuantityDTO(quantity: quantity, ingredient: vmIng.ingredients[index])
    }
}  
