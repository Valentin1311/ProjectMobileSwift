//
//  StockPage.swift
//  PMS
//
//  Created by m1 on 22/02/2022.
//  Copyright © 2022 	. All rights reserved.
//

import SwiftUI

struct StockPage: View {
    @StateObject var vmIng = IngredientsVM()
    var body: some View {
        List() {
            ForEach($vmIng.ingredients, id: \.id) { $ingredient in
                HStack() {
                    Text(ingredient.name)
                }
            }
        }
    }
} 
