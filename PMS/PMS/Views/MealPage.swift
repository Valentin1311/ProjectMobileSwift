//
//  MealPage.swift
//  PMS
//
//  Created by m1 on 22/02/2022.
//  Copyright © 2022 	. All rights reserved.
//

import SwiftUI

struct MealPage: View {
    @State private var index = 0
    @Binding var meal: MealDTO
    @State private var editClicked = false
    @State var showConfirmAlert = false
    @State var oldNbGuests = 0
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack(alignment: .firstTextBaseline, spacing: 10) {
                Text(meal.name).font(.title2).lineLimit(1)
                Spacer()
                Button(action: {
                    printFiche()
                }) {
                    Image(systemName: "printer").imageScale(.large).foregroundColor(.accentColor)
                }
            }.padding()
            TabView(selection: $index) {
                ForEach((0..<meal.stageList.count), id: \.self) { index in
                    StageView(stage: meal.stageList[index], vm: StagePageVM(), stageIndex: index, editable: false)
                }
            }.tabViewStyle(PageTabViewStyle())
            .onAppear {
              setupAppearance()
            }
            Spacer()
            HStack(spacing: 15) {
                HStack(alignment: .center, spacing: 10) {
                    Image(systemName: "fork.knife")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 30, height: 30).foregroundColor(.accentColor)
                    Text("\(meal.nbGuests)")
                    if editClicked {
                        Stepper("", value: $meal.nbGuests, in: 0...1000, step: 1)
                        Button(action: { editClicked = false; updateMeal() }) {
                            Image(systemName: "checkmark")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 30, height: 30).foregroundColor(.accentColor)
                        }
                        Spacer()
                    }
                    else {
                        Button(action: { editClicked = true }) {
                            Image(systemName: "pencil")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 30, height: 30).foregroundColor(.accentColor)
                        }
                    }
                }
                Spacer()
                Text("\(index + 1)/\(meal.stageList.count)").font(.headline)
            }.padding()
        }.onAppear {
            oldNbGuests = meal.nbGuests
        }
    }
    
    func updateMeal() {
        meal.stageList.forEach { stage in
            stage.ingredients.forEach { ingredient in
                ingredient.quantity = ingredient.quantity * meal.nbGuests / oldNbGuests
            }
        }
        MealDAO().updateOrAddMeal(meal: meal)
    }
    
    func printFiche() {
        
    }
    
    func leftClicked() {
        if index != 0 {
            index -= 1
        }
    }
    
    func rightClicked() {
        if index != meal.stageList.count - 1 {
            index += 1
        }
    }
    
    func setupAppearance() {
      UIPageControl.appearance().currentPageIndicatorTintColor = .black
      UIPageControl.appearance().pageIndicatorTintColor = UIColor.black.withAlphaComponent(0.2)
    }
} 
