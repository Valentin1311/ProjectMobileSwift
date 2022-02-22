//
//  IngredientSelectorView.swift
//  PMS
//
//  Created by m1 on 22/02/2022.
//  Copyright © 2022 	. All rights reserved.
//

import SwiftUI

struct IngredientSelectorView: View {
    @StateObject var vmIng = IngredientsVM()
    @State private var indexIngredientSelected = 0
    @StateObject var ingredientSelected : IngredientQuantityDTO = IngredientQuantityDTO(quantity: nil, id: nil, name: "Ingrédient", isAllergern: false, category: "", price: "", unit: "NA", stock: 0, allergenCategory: nil)
    
    var body: some View {
        HStack() {
            TextField("12", value: $ingredientSelected.quantity, formatter: NumberFormatter())
            Text("\(ingredientSelected.unit)")
            Picker(selection: $indexIngredientSelected, label: Text("Ingrédient")) {
                ForEach(0 ..< $vmIng.ingredients.count) {
                    Text(self.vmIng.ingredients[$0].name)
                }
            }.id(UUID())
        }
    }
} 
