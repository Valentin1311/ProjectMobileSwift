//
//  StageView.swift
//  PMS
//
//  Created by m1 on 22/02/2022.
//  Copyright © 2022 	. All rights reserved.
//

import SwiftUI

struct StageView: View {
    @StateObject var stage: StageDTO
    @State var nbIngredientSelectors = 0
    var editable : Bool = true
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("Intitulé").font(.headline).isHidden(!editable)
            TextField("Intitulé", text: $stage.name).font(.title3).disabled(!editable)
            HStack() {
                Text("Ingrédients").font(.headline)
                Spacer()
                Button(action: {
                    nbIngredientSelectors += 1
                }) {
                    Image(systemName: "pencil.tip.crop.circle.badge.plus").imageScale(.large).foregroundColor(.accentColor)
                }
            }
            VStack(alignment: .leading, spacing: 2) {
                if editable {
                    VStack() {
                        ForEach(0 ..< nbIngredientSelectors, id: \.self) { _ in
                            IngredientSelectorView()
                        }
                    }
                }
                else {
                    if let ingredients = stage.ingredients {
                        ForEach(ingredients, id: \.id) { ingredient in
                            HStack() {
                                Text(ingredient.name)
                                Spacer()
                                Text(ingredient.unit)
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
                }
            }.padding().overlay(RoundedRectangle(cornerRadius: 8).stroke(Color.black, lineWidth: 2))
            Text("Description").font(.headline)
            HStack() {
                if editable {
                    TextField("Description", text: $stage.description)
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
                TextField("15", value: $stage.description, formatter: NumberFormatter())
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
