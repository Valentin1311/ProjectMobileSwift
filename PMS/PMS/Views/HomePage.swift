//
//  HomePage.swift
//  PMS
//
//  Created by m1 on 22/02/2022.
//  Copyright © 2022 	. All rights reserved.
//

import SwiftUI

struct HomePage: View {
    @StateObject var vm = MealVM()
    var body: some View {
        NavigationView() {
            List() {
                ForEach($vm.meals, id: \.id) { $meal in
                    NavigationLink(destination: MealPage(meal: $meal)) {
                        Text(meal.name)
                    }.navigationTitle("Fiches techniques")
                }
            }
        }
    }
} 
